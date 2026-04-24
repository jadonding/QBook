import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:qbook/shared/enums/app_tab.dart';

class AppShellPage extends StatelessWidget {
  const AppShellPage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final String location =
        GoRouterState.of(context).uri.toString();
    final AppTab currentTab = AppTab.fromLocation(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentTab.index,
        destinations: AppTab.values
            .map(
              (AppTab tab) => NavigationDestination(
                icon: Icon(tab.icon),
                label: tab.label,
              ),
            )
            .toList(),
        onDestinationSelected: (int index) {
          final AppTab target = AppTab.values[index];
          if (target != currentTab) {
            context.go(target.path);
          }
        },
      ),
    );
  }
}

