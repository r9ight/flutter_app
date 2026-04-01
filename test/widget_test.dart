import 'package:flutter_test/flutter_test.dart';
import 'package:seamless_cpr_flutter/src/app.dart';

void main() {
  testWidgets('shows the CPR home prompt', (WidgetTester tester) async {
    await tester.pumpWidget(const SeamlessCprApp());
    await tester.pumpAndSettle();

    expect(find.text('Quick instructions to save lives.'), findsOneWidget);
    expect(find.text('Save Lives'), findsOneWidget);
  });
}
