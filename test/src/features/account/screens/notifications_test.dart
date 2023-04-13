import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/account/screens/notifications.dart';

void main() {
  testWidgets('Notifications screen has Notifications heading', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Notifications()),
      ),
    );

    //When
    final notificationsFinder = find.text('Notifications');

    //Then
    expect(notificationsFinder, findsOneWidget);
  });
}