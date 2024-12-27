import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:personal_finance/main.dart' as app;
import 'package:personal_finance/screens/login_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('login flow test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Iniciar Sesion').at(0), findsOneWidget);

    final loginButton = find.widgetWithText(ElevatedButton, 'Iniciar sesion');
    expect(loginButton, findsOneWidget);

    final emailField = find.byType(TextFormField).first;
    final passwordField = find.byType(TextFormField).last;
    await tester.enterText(emailField, "alisonjimenez@gmail.com");
    await tester.enterText(passwordField, "123456");

    await tester.tap(loginButton);
    await tester.pumpAndSettle();
  });
}
