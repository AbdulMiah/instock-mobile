import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/authentication/screens/welcome_page.dart';

void main() {
  testWidgets('Welcome screen has Welcome text', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Welcome()),
      ),
    );

    //When
    final welcomeFinder = find.text('Welcome To InStock');

    //Then
    expect(welcomeFinder, findsOneWidget);
  });

  testWidgets('Welcome screen has Login text', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Welcome()),
      ),
    );

    //When
    final loginFinder = find.text('Login');

    //Then
    expect(loginFinder, findsOneWidget);
  });

  testWidgets('Welcome screen has Sign Up text', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Welcome()),
      ),
    );

    //When
    final signUpFinder = find.text('Sign Up');

    //Then
    expect(signUpFinder, findsOneWidget);
  });

  testWidgets('When Login Button is pressed redirects to login page',
      (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Welcome()),
      ),
    );

    final signUpFinder = find.text('Login');

    //When
    await tester.tap(signUpFinder);
    await tester.pumpAndSettle();
    final emailFinder = find.text('Email');
    //Then
    expect(emailFinder, findsAtLeastNWidgets(1));
  });

  testWidgets('When Sign Up Button is pressed redirects to sign up page',
      (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Welcome()),
      ),
    );

    final signUpFinder = find.text('Sign Up');

    //When
    await tester.tap(signUpFinder);
    await tester.pumpAndSettle();
    final comingSoonFinder = find.text('Coming Soon');
    //Then
    expect(comingSoonFinder, findsAtLeastNWidgets(1));
  });
}
