import 'package:flutter/material.dart';

import 'package:qbook/shared/widgets/placeholder_page_scaffold.dart';

class TransactionEntryPage extends StatelessWidget {
  const TransactionEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPageScaffold(
      title: '记账',
      description: '这里将提供收入、支出、转账和智能记账录入入口。',
    );
  }
}

