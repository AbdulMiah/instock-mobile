import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/account/screens/contact_us.dart';

void main() {
  testWidgets('Contact Us screen has Contact Us heading', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ContactUs()),
      ),
    );

    //When
    final contactUsFinder = find.text('Contact Us');

    //Then
    expect(contactUsFinder, findsOneWidget);
  });

  testWidgets('Contact Us screen has Topic field', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ContactUs()),
      ),
    );

    //When
    final topicFinder = find.text('Topic');

    //Then
    expect(topicFinder, findsOneWidget);
  });

  testWidgets('Contact Us screen has Message field', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ContactUs()),
      ),
    );

    //When
    final messageFinder = find.text('Message');

    //Then
    expect(messageFinder, findsOneWidget);
  });

  testWidgets('Contact Us screen has Send button', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ContactUs()),
      ),
    );

    //When
    final sendFinder = find.text('Send');

    //Then
    expect(sendFinder, findsOneWidget);
  });
}