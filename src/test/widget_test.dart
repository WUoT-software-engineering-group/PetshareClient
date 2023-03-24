import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'Simple test just for github actions purpouses - should be removed in the future',
      ((widgetTester) async {
    expect(find.text('Text that won\'t be found'), findsNothing);
  }));
}
