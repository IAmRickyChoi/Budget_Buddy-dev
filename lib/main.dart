import 'package:budget_buddy/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  // ProviderScope는 모든 Provider의 상태를 담는 컨테이너다.
  // 앱 최상단에 한 번만 둔다.
  runApp(const ProviderScope(child: App()));
}
