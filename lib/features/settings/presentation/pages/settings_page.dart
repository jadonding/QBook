import 'package:flutter/material.dart';

import 'package:qbook/shared/widgets/placeholder_page_scaffold.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPageScaffold(
      title: '我的',
      description: '这里将管理账户、分类、账本、同步、导入导出和设置。',
    );
  }
}

