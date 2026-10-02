# Budget Buddy

전 세계 사용자를 위한 오프라인 우선 가계부 앱 (Flutter).

설계 결정과 그 이유는 [docs/architecture.md](docs/architecture.md)에 정리되어 있습니다.

## 기술 스택

- 상태관리: Riverpod 3 + riverpod_generator
- 라우팅: go_router (`StatefulShellRoute.indexedStack`으로 하단 탭)
- 다국어: flutter_localizations + gen-l10n (ko / en / ja)
- 로컬 DB: Drift (SQLite), 오프라인 우선
- 모델: freezed
- 백엔드: Firebase (예정)

## 실행

```bash
flutter pub get
flutter run
```

## 코드 생성

`@riverpod`·`@freezed`·Drift 테이블을 고치거나 `lib/l10n/*.arb`를 고친 뒤에는 생성 파일을 다시 만듭니다.
생성된 `*.g.dart`와 `lib/l10n/app_localizations*.dart`는 바로 실행할 수 있도록 커밋해 둡니다.

```bash
dart run build_runner build -d   # Riverpod, freezed, Drift
flutter gen-l10n                 # 다국어
```

## 폴더 구조

```
lib/
  main.dart                 # ProviderScope로 앱 시작
  app/                      # 앱 전체 설정: MaterialApp, 라우터, 하단 탭 껍데기, 테마
  core/                     # 여러 기능이 같이 쓰는 코드 (l10n 확장, 이후 DB·동기화·Money)
  features/<기능>/
    domain/                 # 엔티티, Repository 인터페이스 (Flutter·DB 의존 없음)
    data/                   # Drift·Firestore 구현체
    presentation/           # 화면, 위젯, Notifier
  l10n/                     # 번역 파일 (ARB)
```

## 검사

```bash
flutter analyze
flutter test
```
