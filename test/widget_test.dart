import 'package:flutter_test/flutter_test.dart';
import 'package:rs_flutter_test/main.dart';

final app = MyHomePage();

void main() {
  group("UI Test", uiTest);
}

void uiTest() {
  testWidgets('Default Switch Test', (WidgetTester tester) async {
    // final BuildContext context = tester.element(find.byType(Scaffold));

    await tester.pumpWidget(MyHomePage());

    final defaultTitle = find.text("FlutterSwitch Demo");

    expect(defaultTitle, findsOneWidget);
  });
}
