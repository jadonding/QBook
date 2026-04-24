import 'package:flutter/material.dart';

import 'package:qbook/shared/widgets/placeholder_page_scaffold.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPageScaffold(
      title: '统计',
      description: '这里将展示月度趋势、分类占比、预算和资产统计。',
    );
  }
}

