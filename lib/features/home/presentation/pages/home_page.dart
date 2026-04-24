import 'package:flutter/material.dart';

import 'package:qbook/shared/widgets/placeholder_page_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPageScaffold(
      title: '首页',
      description: '这里将展示本月收支、预算进度、净资产和最近账单。',
    );
  }
}

