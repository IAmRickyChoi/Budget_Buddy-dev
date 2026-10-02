/// 행이 서버와 맞춰졌는지 표시한다. 3단계(동기화)에서 SyncService가 쓴다.
enum SyncState {
  /// 서버와 같은 상태.
  synced,

  /// 로컬에서 바뀌었고 아직 서버로 보내지 않음.
  pending,
}
