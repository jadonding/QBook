import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:qbook/features/app_shell/presentation/pages/app_shell_page.dart';
import 'package:qbook/features/home/presentation/pages/home_page.dart';
import 'package:qbook/features/ledger/presentation/pages/ledger_page.dart';
import 'package:qbook/features/settings/presentation/pages/settings_page.dart';
import 'package:qbook/features/statistics/presentation/pages/statistics_page.dart';
import 'package:qbook/features/transaction/presentation/pages/transaction_entry_page.dart';
import 'package:qbook/shared/enums/app_tab.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppTab.home.path,
    routes: <RouteBase>[
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return AppShellPage(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppTab.home.path,
            name: AppTab.home.routeName,
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
          ),
          GoRoute(
            path: AppTab.ledger.path,
            name: AppTab.ledger.routeName,
            builder: (BuildContext context, GoRouterState state) {
              return const LedgerPage();
            },
          ),
          GoRoute(
            path: AppTab.entry.path,
            name: AppTab.entry.routeName,
            builder: (BuildContext context, GoRouterState state) {
              return const TransactionEntryPage();
            },
          ),
          GoRoute(
            path: AppTab.statistics.path,
            name: AppTab.statistics.routeName,
            builder: (BuildContext context, GoRouterState state) {
              return const StatisticsPage();
            },
          ),
          GoRoute(
            path: AppTab.settings.path,
            name: AppTab.settings.routeName,
            builder: (BuildContext context, GoRouterState state) {
              return const SettingsPage();
            },
          ),
        ],
      ),
    ],
  );
}

