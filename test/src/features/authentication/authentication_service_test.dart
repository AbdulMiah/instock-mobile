import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/authentication/login_page.dart';

// class MockAuthenticationService extends Mock implements AuthenticationService {}

void main() {
  testWidgets('Login screen has Login text and button', (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Login()),
      ),
    );

    //When
    final loginFinder = find.text('Login');

    //Then
    expect(loginFinder, findsNWidgets(2));
  });
}
// Mock save bearer token
// Mock retrieve bearer token
//
