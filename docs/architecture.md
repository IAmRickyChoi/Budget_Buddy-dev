# 가계부 앱 아키텍처 설계안 (v0.2)

작성일: 2026-10-02
전제: 처음부터 새로 만듦 · 상태관리 Riverpod · 클라우드 동기화 포함 · 전 세계 출시

각 결정은 **결정 → 이유 → 버린 대안** 순서로 적었습니다. 면접에서 "왜 이렇게 했나요?"라는 질문에 그대로 답할 수 있게 쓰는 것이 목표입니다.

---

## 1. 큰 그림: 오프라인 우선 (Local-first)

```
 UI (Widget)
   │  ref.watch
   ▼
 Riverpod Provider / Notifier          ← 화면 상태, 사용자 액션 처리
   │
   ▼
 Repository (interface)                ← 도메인이 아는 유일한 데이터 창구
   │
   ▼
 Local DB (Drift/SQLite)  ◀──────▶  SyncService  ◀──────▶  Cloud (Firestore)
   "진실의 원천"                      백그라운드 push/pull
```

- **결정**: 앱은 항상 로컬 DB에만 읽고 씁니다. 클라우드는 SyncService가 뒤에서 맞춰 줍니다.
- **이유**
  - 가계부는 "지금 바로 한 줄 적기"가 핵심 UX입니다. 지하철, 해외여행처럼 네트워크가 나쁜 곳에서도 입력이 즉시 끝나야 합니다.
  - UI는 Drift의 `watch()` 스트림을 구독합니다. 사용자가 입력하든 동기화가 다른 기기 데이터를 내려받든 **DB만 바뀌면 화면은 자동으로 갱신**됩니다. 화면 코드가 동기화를 전혀 몰라도 됩니다.
  - 월별 합계, 카테고리별 통계 같은 집계를 로컬 SQL로 즉시 계산할 수 있습니다.
- **버린 대안**
  - *서버가 진실의 원천 (매번 API 호출)*: 오프라인에서 못 쓰고, 입력마다 로딩이 생깁니다.
  - *Firestore 오프라인 캐시만 사용*: 구현은 쉽지만 집계 쿼리가 약하고(SUM/GROUP BY 제약), 캐시가 언제 비워질지 제어할 수 없습니다. 데이터 계층이 Firestore에 묶여 백엔드 교체도 어려워집니다.

## 2. 레이어 구조

| 레이어 | 하는 일 | 의존 방향 |
|---|---|---|
| presentation | 위젯, 화면 상태(Notifier), 라우팅 | → domain |
| domain | 엔티티(Transaction, Account…), Repository **인터페이스**, 순수 비즈니스 규칙(예: 예산 초과 계산) | 아무것도 의존하지 않음 |
| data | Drift 테이블/DAO, Firestore DTO, Repository **구현체**, SyncService | → domain |

- **결정**: 3레이어 + Repository 패턴. 별도의 UseCase 클래스는 만들지 않고, 여러 Repository를 조합하는 로직이 생길 때만 `application` 서비스로 뺍니다.
- **이유**
  - domain이 Flutter, Drift, Firebase를 import하지 않으므로 순수 Dart 단위 테스트가 쉽습니다.
  - Repository 인터페이스 덕분에 테스트에서 가짜 구현으로 갈아끼우거나, 백엔드를 바꿀 때 data 레이어만 수정하면 됩니다.
  - UseCase를 메서드마다 만들면 `AddTransactionUseCase`처럼 Repository를 한 줄 호출만 하는 클래스가 수십 개 생깁니다. 1인 개발 규모에서는 비용 대비 이득이 작습니다.
- **버린 대안**: 정석 Clean Architecture(UseCase 전부 분리) — 면접에서 "알지만 이 규모에선 과하다고 판단했다"고 말할 수 있으면 오히려 좋은 답이 됩니다.

## 3. 폴더 구조: Feature-first

```
lib/
  main.dart
  app/
    app.dart                 # MaterialApp.router, 테마, 로케일
    router.dart              # go_router (StatefulShellRoute로 하단 탭)
    theme/
  core/
    database/                # Drift AppDatabase, 마이그레이션
    sync/                    # SyncService, outbox, 커서 저장
    money/                   # Money 값 객체, 통화 포맷
    l10n/                    # 생성된 AppLocalizations 확장
    utils/
  features/
    auth/
    transactions/
      domain/                # transaction.dart, transaction_repository.dart
      data/                  # transactions_table.dart, transaction_dao.dart,
                             # transaction_repository_impl.dart, transaction_dto.dart
      presentation/          # transaction_list_screen.dart, add_transaction_sheet.dart,
                             # transaction_list_controller.dart
    accounts/
    categories/
    budgets/
    reports/
    receipt_scan/            # ML Kit OCR + Gemini
    settings/
  l10n/
    app_ko.arb
    app_en.arb
    app_ja.arb
test/                        # lib/ 구조를 그대로 따름
```

- **결정**: 기능(feature) 단위로 먼저 나누고, 그 안에서 레이어로 나눕니다.
- **이유**: "거래 입력 기능을 고쳐야 한다"면 `features/transactions/`만 열면 됩니다. 기능이 늘어나도 폴더 하나가 커지지 않고, 나중에 패키지로 떼어내기도 쉽습니다.
- **버린 대안**: Layer-first(`lib/data`, `lib/domain`, `lib/presentation` 아래에 모든 기능) — 작을 땐 깔끔하지만 기능이 10개를 넘으면 한 기능을 고치려고 폴더 세 곳을 오가야 합니다.

## 4. 상태관리: Riverpod 3 + 코드 생성

- **결정**: `flutter_riverpod` + `riverpod_annotation` + `riverpod_generator`. 읽기 전용 목록은 `StreamProvider`(Drift watch), 사용자 액션이 있는 화면은 `AsyncNotifier`.
- **예시 흐름 (거래 추가)**
  1. 위젯 → `ref.read(addTransactionControllerProvider.notifier).submit(form)`
  2. Notifier → `TransactionRepository.add()` → Drift에 insert (`syncState = pending`)
  3. Drift watch 스트림이 새 목록을 방출 → 목록 화면 자동 갱신
  4. SyncService가 pending 행을 감지해 Firestore로 push
- **이유**
  - Provider 간 의존성(`ref.watch(databaseProvider)`)을 컴파일 타임에 안전하게 표현하고, 테스트에서 `ProviderContainer(overrides: [...])`로 쉽게 바꿀 수 있습니다.
  - `BuildContext` 없이 어디서든 접근 가능해서 SyncService 같은 비 UI 객체와도 잘 맞습니다.
  - 코드 생성을 쓰면 Provider 종류(Future/Stream/Notifier)를 직접 고르는 실수가 줄고 family 파라미터도 타입 안전해집니다.
- **버린 대안**: Bloc — 이벤트/상태가 명시적이라 대규모 팀에선 장점이지만 보일러플레이트가 많습니다. (면접 대비로 Bloc과의 차이는 설명할 수 있게 따로 정리해 두면 좋습니다.)

## 5. 로컬 DB: Drift (SQLite)

- **결정**: Drift. *(개요 문서의 Isar에서 변경, 2026-10-02 확정)*
- **이유**
  - 가계부 데이터는 관계형입니다: 거래 ↔ 계좌 ↔ 카테고리 ↔ 예산. 월별 합계, 카테고리별 GROUP BY, 기간 필터가 SQL로 자연스럽습니다.
  - 타입 안전한 쿼리 + `watch()` 스트림 + 버전별 마이그레이션 + 마이그레이션 테스트 도구를 기본 제공합니다. 출시 후 스키마를 바꿔야 하는 실서비스에서 마이그레이션은 필수입니다.
  - SQLite는 모든 플랫폼에서 검증된 엔진이고, Drift는 활발히 유지보수되고 있습니다.
- **버린 대안**
  - *Isar*: 원작자가 유지보수를 중단해 커뮤니티 포크(isar_community)로 넘어간 상태입니다. 수년 운영할 앱의 저장소로는 리스크가 큽니다.
  - *Hive*: 키-값 저장소라 집계/관계 쿼리를 직접 짜야 합니다. (설정값 정도는 `shared_preferences`로 충분)
  - *sqflite 직접 사용*: 문자열 SQL이라 타입 안전성과 반응형 스트림이 없습니다.

## 6. 동기화 설계

### 6.1 모든 동기화 대상 테이블의 공통 컬럼
| 컬럼 | 타입 | 용도 |
|---|---|---|
| `id` | TEXT (UUID v7) | **클라이언트에서 생성**. 오프라인에서 만든 행도 서버와 충돌 없는 고유 ID. v7은 시간순 정렬 가능 |
| `updatedAt` | INTEGER (UTC ms) | 로컬 수정 시각 |
| `serverUpdatedAt` | INTEGER, nullable | 서버가 기록한 시각 (pull 커서용) |
| `deletedAt` | INTEGER, nullable | **소프트 삭제(tombstone)**. 진짜로 지우면 다른 기기가 삭제 사실을 알 수 없음 |
| `syncState` | INTEGER | `synced` / `pending` |

### 6.2 흐름
- **Push**: `syncState = pending`인 행을 모아 Firestore `users/{uid}/{collection}/{id}`에 batch write (`serverUpdatedAt = FieldValue.serverTimestamp()`). 성공하면 `synced`로 표시.
- **Pull**: 컬렉션별로 마지막으로 받은 `serverUpdatedAt` 커서를 저장해 두고, 그 이후 변경분만 쿼리 → 로컬에 upsert.
- **충돌 해결**: 레코드 단위 Last-Write-Wins. 단, 로컬에 아직 push 안 된 `pending` 변경이 있으면 그 행은 pull로 덮어쓰지 않습니다.
- **실행 시점**: 앱 시작, 포그라운드 복귀, 로컬 쓰기 후 몇 초 디바운스, 네트워크 복구 시. (백그라운드 주기 동기화는 iOS 제약이 커서 v2에서 `workmanager`로 검토)
- **Firestore 자체 오프라인 캐시는 끔**: 로컬 DB가 이미 진실의 원천이므로 캐시가 두 벌이 될 필요가 없습니다.

### 6.3 왜 이 수준에서 멈추나
- 개인 가계부는 "한 사용자, 여러 기기"입니다. 같은 거래를 두 기기에서 동시에 고치는 일은 드물어서 LWW로 충분합니다.
- 공동 가계부(가족 공유)를 하게 되면 필드 단위 병합이나 CRDT가 필요해지는데, 그때 SyncService만 바꾸면 되도록 경계를 나눠 둡니다.
- **버린 대안**: PowerSync / ElectricSQL 같은 동기화 엔진 — 빠르지만 핵심 로직이 블랙박스가 되어 면접에서 설명할 거리가 사라집니다. 직접 구현하는 것 자체가 포트폴리오 가치입니다.

## 7. 돈과 통화 처리

- **결정 1: 금액은 정수(최소 단위)로 저장**. `amountMinor: int` + `currencyCode: String`(ISO 4217).
  - 예: $12.34 → `1234`, `USD` / ₩12,000 → `12000`, `KRW` / ¥500 → `500`, `JPY`
  - **이유**: `double`은 `0.1 + 0.2 != 0.3` 같은 부동소수점 오차가 있어 돈 계산에 쓰면 안 됩니다. 이건 면접 단골 질문입니다.
  - 통화마다 소수 자릿수가 다릅니다(KRW·JPY 0, USD 2, BHD·KWD 3). 자릿수 표를 `core/money/`에 두고 변환합니다.
- **결정 2: `Money` 값 객체**. 금액과 통화를 항상 묶어서 다니고, 다른 통화끼리 더하면 예외를 던집니다. 통화 섞임 버그를 타입 수준에서 막습니다.
- **결정 3: 표시 형식은 `intl`의 `NumberFormat.currency(locale:, name:)`**. 같은 1234.5 USD라도 en_US는 `$1,234.50`, de_DE는 `1.234,50 $`로 나와야 합니다.
- **결정 4: 계좌마다 통화가 하나**. 거래는 계좌 통화로 저장합니다. 여러 통화를 합친 총자산/리포트는 **거래 시점의 환율 스냅샷**을 함께 저장해 기준 통화로 환산합니다(v2). 오늘 환율로 과거를 다시 계산하면 지난달 리포트 숫자가 매일 바뀌기 때문입니다.

## 8. 날짜와 시간대

- **결정**: 거래에 `occurredOn`(사용자 기준 로컬 날짜, `yyyy-MM-dd`)과 `createdAt`(UTC 타임스탬프)을 따로 저장합니다.
- **이유**: 서울에서 3월 1일 오전 1시에 쓴 지출을 UTC로만 저장하면 2월 28일로 집계될 수 있습니다. 사용자가 "3월 1일에 썼다"고 생각한 날짜를 그대로 보존해야 월별 집계가 직관대로 나옵니다. 해외여행 중 시간대가 바뀌어도 기존 기록의 날짜가 흔들리지 않습니다.
- 월 시작일(예: 월급날 25일 기준)은 설정값으로 두고 집계 쿼리에서 반영합니다.

## 9. 다국어 (i18n)

- **결정**: Flutter 공식 `flutter_localizations` + `gen-l10n`(ARB 파일). 초기 언어 ko / en / ja.
- **이유**: 공식 방식이라 문서와 레퍼런스가 많고, 복수형·성별 같은 ICU 메시지 형식을 지원합니다. 번역 서비스(Crowdin 등)도 ARB를 바로 받습니다.
- **함께 지킬 규칙**
  - 화면 문자열은 하드코딩 금지, 전부 ARB 키.
  - 숫자·날짜·통화는 반드시 `intl` 포맷터 사용.
  - 아랍어 같은 RTL 대비: `EdgeInsets.only(left:)` 대신 `EdgeInsetsDirectional.only(start:)`.
- **버린 대안**: `easy_localization` — 설정이 간단하지만 코드 생성 기반 타입 안전성이 약하고 비공식입니다.

## 10. 백엔드: Firebase (2026-10-02 확정)

- **결정**: Firebase (Auth + Firestore + Firebase AI Logic + Crashlytics/Analytics)
- **이유**
  - 개요 문서에 이미 Firebase Auth와 Gemini가 있습니다. 같은 생태계로 묶으면 설정과 결제가 한 곳입니다.
  - **Firebase AI Logic**으로 앱에서 Gemini를 직접 호출하되 API 키를 앱에 넣지 않고 App Check로 보호할 수 있습니다. 영수증 인식 때문에 Go 서버를 먼저 만들 필요가 없어집니다.
  - 로컬 DB가 진실의 원천이므로 Firestore는 "사용자별 문서 저장소" 역할만 하면 됩니다. Firestore의 약점(집계 쿼리)은 로컬 SQL이 대신합니다.
  - Google/Apple 로그인, 푸시(FCM), 원격 설정, 크래시 리포트까지 Flutter 공식 플러그인이 있습니다. 국내 Flutter 채용 공고에서도 Firebase 경험을 자주 요구합니다.
- **Supabase를 고른다면**: Postgres라 서버 측 SQL 집계, RLS 권한, 예측 가능한 요금이 장점입니다. 다만 로컬에서 이미 SQL 집계를 하므로 이 앱에서는 그 장점이 덜 중요하고, Gemini 호출용 서버(Edge Function)를 따로 짜야 합니다.
- **Go 서버와 함께 쓰기**: Firebase와 Go는 함께 쓸 수 있습니다. 앱은 Firebase Auth로 로그인하고, Go 서버를 부를 때 Firebase ID 토큰을 헤더에 실어 보냅니다. Go 서버는 Firebase Admin SDK(Go용 공식 제공)로 토큰을 검증하고, 필요하면 Firestore도 직접 읽고 씁니다.
  - Go가 맡기 좋은 일: 환율 수집(하루 한 번 받아 저장), 구독 영수증 검증/웹훅 처리, Gemini 호출 프록시(프롬프트와 비용을 서버에서 통제하고 싶을 때), 데이터 내보내기.
  - 배포: Cloud Run(같은 Google Cloud라 연동이 쉬움) 또는 개인 NAS.
  - v1에서는 만들지 않고, 위 기능 중 하나가 필요해지는 시점에 추가합니다. 앱의 data 레이어에 `ApiClient`만 하나 더 생기는 구조라 나중에 붙여도 기존 코드가 흔들리지 않습니다.

## 11. 주요 패키지

| 용도 | 패키지 | 메모 |
|---|---|---|
| 상태관리 | `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator` | 3.x |
| 로컬 DB | `drift`, `drift_flutter`, `drift_dev` | |
| 모델 | `freezed`, `json_serializable` | 불변 엔티티, copyWith, DTO 변환 |
| 라우팅 | `go_router` | `StatefulShellRoute.indexedStack`이 개요의 "하단 탭 + IndexedStack"을 그대로 지원 |
| 백엔드 | `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_ai`, `firebase_app_check`, `firebase_crashlytics` | |
| 로그인 | `google_sign_in`, `sign_in_with_apple` | iOS는 소셜 로그인 제공 시 Apple 로그인 필수 |
| 영수증 | `google_mlkit_text_recognition`, `image_picker` | OCR 후 텍스트를 Gemini로 구조화 |
| 다국어 | `flutter_localizations`, `intl` | |
| 유틸 | `uuid`(v7), `connectivity_plus` | |
| 수익화 | `purchases_flutter`(RevenueCat) 또는 `in_app_purchase`, `google_mobile_ads` | Pro 구독 시점에 결정 |
| 테스트·품질 | `mocktail`, `very_good_analysis` | |

## 12. 테스트 전략

- **domain**: 순수 Dart 단위 테스트 (Money 연산, 예산 계산).
- **data**: Drift 인메모리 DB(`NativeDatabase.memory()`)로 DAO·Repository 테스트, 마이그레이션 테스트.
- **sync**: 가짜 원격 저장소로 "오프라인 입력 → 재연결 → push", "pending 행은 pull로 안 덮임" 시나리오.
- **presentation**: `ProviderContainer` override로 Notifier 테스트, 주요 화면 위젯 테스트.

## 13. 구현 순서 (제안)

1. 프로젝트 생성, 린트, 폴더 뼈대, go_router 하단 탭, 다국어 세팅
2. Drift 스키마(계좌·카테고리·거래) + Money 값 객체 + 거래 입력/목록 (완전 오프라인으로 동작)
3. 월별 리포트, 예산
4. Firebase Auth 로그인 + SyncService (push → pull → 충돌 처리)
5. 영수증 스캔 (ML Kit + Gemini)
6. Pro 구독, 광고, 출시 준비

## 14. 면접 예상 질문 메모

- 왜 오프라인 우선인가? 동기화 충돌은 어떻게 처리했나? → 1장, 6장
- 돈을 왜 double로 안 쓰나? 통화 자릿수는? → 7장
- 시간대 문제를 어떻게 다뤘나? → 8장
- Riverpod을 고른 이유, Bloc과 비교하면? → 4장
- Clean Architecture를 어디까지 적용했고 왜 거기서 멈췄나? → 2장
- Isar 대신 Drift를 쓴 이유는? → 5장
