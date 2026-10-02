import 'package:budget_buddy/app/home_shell.dart';
import 'package:budget_buddy/features/budgets/presentation/budgets_screen.dart';
import 'package:budget_buddy/features/reports/presentation/reports_screen.dart';
import 'package:budget_buddy/features/settings/presentation/settings_screen.dart';
import 'package:budget_buddy/features/transactions/presentation/add_transaction_screen.dart';
import 'package:budget_buddy/features/transactions/presentation/transactions_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

abstract final class AppRoutes {
  static const transactions = '/transactions';
  static const reports = '/reports';
  static const budgets = '/budgets';
  static const settings = '/settings';
  static const addTransaction = '/transactions/new';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// 라우터를 Provider로 두면 나중에 로그인 상태(authProvider)를 watch해서
/// 로그인 전이면 로그인 화면으로 보내는 redirect를 한 곳에서 처리할 수 있다.
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.transactions,
    routes: [
      // indexedStack: 탭마다 자기 Navigator를 갖고, 탭을 바꿔도
      // 이전 탭의 스크롤 위치와 화면 스택이 그대로 남는다.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.transactions,
                builder: (context, state) => const TransactionsScreen(),
                routes: [
                  // 추가 화면은 하단 탭을 가리고 전체 화면으로 띄운다.
                  GoRoute(
                    path: 'new',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const AddTransactionScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.reports,
                builder: (context, state) => const ReportsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.budgets,
                builder: (context, state) => const BudgetsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
