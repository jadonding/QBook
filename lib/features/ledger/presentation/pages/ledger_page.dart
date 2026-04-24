import 'package:flutter/material.dart';

import 'package:qbook/shared/widgets/placeholder_page_scaffold.dart';

class LedgerPage extends StatelessWidget {
  const LedgerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPageScaffold(
      title: '账单',
      description: '这里将提供账单列表、搜索、筛选、详情和批量编辑。',
    );
  }
}

