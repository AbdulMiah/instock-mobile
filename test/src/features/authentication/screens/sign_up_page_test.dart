import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/authentication/screens/sign_up_page.dart';

void main() {
  testWidgets('Sign Up screen Renders', (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SignUp()),
      ),
    );

    //When
    final loginFinder = find.text('Sign Up');

    //Then
    expect(loginFinder, findsNWidgets(2));
  });

  testWidgets('Sign Up has all fields needed for user to register',
      (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SignUp()),
      ),
    );

    final loginFinder = find.text('Sign Up');
  });
}
