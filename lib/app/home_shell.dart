import 'package:budget_buddy/app/router.dart';
import 'package:budget_buddy/core/l10n/l10n_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 하단 탭 4개와 가운데 홈이 파인(notched) FAB를 그리는 껍데기 화면.
/// 각 탭의 실제 화면은 [navigationShell]이 IndexedStack으로 들고 있다.
class HomeShell extends StatelessWidget {
  const HomeShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onTabTap(int index) {
    navigationShell.goBranch(
      index,
      // 이미 선택된 탭을 다시 누르면 그 탭의 첫 화면으로 돌아간다.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tabs = [
      (Icons.receipt_long_outlined, Icons.receipt_long, l10n.tabTransactions),
      (Icons.pie_chart_outline, Icons.pie_chart, l10n.tabReports),
      (Icons.savings_outlined, Icons.savings, l10n.tabBudgets),
      (Icons.settings_outlined, Icons.settings, l10n.tabSettings),
    ];

    Widget tab(int index) {
      final (icon, selectedIcon, label) = tabs[index];
      return Expanded(
        child: _TabButton(
          icon: icon,
          selectedIcon: selectedIcon,
          label: label,
          selected: navigationShell.currentIndex == index,
          onTap: () => _onTabTap(index),
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addTransaction),
        tooltip: l10n.addTransaction,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            tab(0),
            tab(1),
            // FAB가 들어갈 가운데 자리
            const SizedBox(width: 72),
            tab(2),
            tab(3),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final color = selected ? colors.primary : colors.onSurfaceVariant;

    return Semantics(
      selected: selected,
      button: true,
      child: InkResponse(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(selected ? selectedIcon : icon, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: color),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
