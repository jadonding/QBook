import 'package:flutter/material.dart';

enum AppTab {
  home(
    routeName: 'home',
    path: '/',
    label: '首页',
    icon: Icons.space_dashboard_rounded,
  ),
  ledger(
    routeName: 'ledger',
    path: '/ledger',
    label: '账单',
    icon: Icons.receipt_long_rounded,
  ),
  entry(
    routeName: 'entry',
    path: '/entry',
    label: '记账',
    icon: Icons.add_circle_rounded,
  ),
  statistics(
    routeName: 'statistics',
    path: '/statistics',
    label: '统计',
    icon: Icons.insights_rounded,
  ),
  settings(
    routeName: 'settings',
    path: '/settings',
    label: '我的',
    icon: Icons.person_rounded,
  );

  const AppTab({
    required this.routeName,
    required this.path,
    required this.label,
    required this.icon,
  });

  final String routeName;
  final String path;
  final String label;
  final IconData icon;

  static AppTab fromLocation(String location) {
    return values.firstWhere(
      (AppTab tab) => location == tab.path,
      orElse: () {
        if (location.startsWith('/ledger')) {
          return AppTab.ledger;
        }
        if (location.startsWith('/entry')) {
          return AppTab.entry;
        }
        if (location.startsWith('/statistics')) {
          return AppTab.statistics;
        }
        if (location.startsWith('/settings')) {
          return AppTab.settings;
        }
        return AppTab.home;
      },
    );
  }
}

