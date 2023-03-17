import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/account/account_page.dart';

///
void main() {
  testWidgets('Account Page has log out button', (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: AccountPage()),
      ),
    );

    //When
    final loginFinder = find.text('Log Out');

    //Then
    expect(loginFinder, findsOneWidget);
  });

  testWidgets('Account Page pop out displays when log out button pressed',
      (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: AccountPage()),
      ),
    );

    //When
    final logOutFinder = find.text('Log Out');

    await tester.tap(logOutFinder);
    await tester.pumpAndSettle();
    //Then
    final popOutFinder = find.text('Are you sure you want to Log Out?');
    expect(popOutFinder, findsOneWidget);
  });

  testWidgets('Account Page pop out can be closed', (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: AccountPage()),
      ),
    );

    //When
    final logOutFinder = find.text('Log Out');

    await tester.tap(logOutFinder);
    await tester.pumpAndSettle();

    final cancelFinder = find.text('Cancel');
    await tester.tap(cancelFinder);
    await tester.pumpAndSettle();

    //Then
    final popOutFinderUpdated = find.text('Are you sure you want to Log Out?');
    expect(popOutFinderUpdated, findsNothing);
  });

  // Not done test for clicking log out button because that requires
  // mock for authentication service
}
