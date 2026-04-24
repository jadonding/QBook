import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qbook/app/app.dart';

void main() {
  testWidgets('renders the QBook app shell', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: QBookApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('首页'), findsWidgets);
    expect(find.text('账单'), findsOneWidget);
    expect(find.text('记账'), findsOneWidget);
    expect(find.text('统计'), findsOneWidget);
    expect(find.text('我的'), findsOneWidget);
  });
}
