import 'package:auto_control_panel/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('description', (WidgetTester tester) async {
    await tester.pumpWidget(SigninScreen());

    final textFieldEmail = find.byKey(const Key('textFieldSigninEmail'));

    expect(textFieldEmail, findsOneWidget);
  });
}
