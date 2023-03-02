import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/business/screens/add_business_page.dart';

void main() {
  testWidgets('Add business screen has Add Business heading', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AddBusiness()),
      ),
    );

    //When
    final addBusinessFinder = find.text('Add Business');

    //Then
    expect(addBusinessFinder, findsOneWidget);
  });

  testWidgets('Add Business screen has business name field', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AddBusiness()),
      ),
    );

    //When
    final businessNameFinder = find.text('Enter business name');

    //Then
    expect(businessNameFinder, findsOneWidget);
  });

  testWidgets('Add Business screen has description field', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AddBusiness()),
      ),
    );

    //When
    final descriptionFinder = find.text('Enter the description');

    //Then
    expect(descriptionFinder, findsOneWidget);
  });

  testWidgets('Add Business screen has Continue button', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AddBusiness()),
      ),
    );

    //When
    final continueFinder = find.text('Continue');

    //Then
    expect(continueFinder, findsOneWidget);
  });
}