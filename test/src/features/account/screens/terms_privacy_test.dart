import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/account/screens/terms_privacy.dart';

void main() {
  testWidgets('Terms & Privacy screen has Terms & Privacy heading', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: TermsPrivacy()),
      ),
    );

    //When
    final termsPrivacyFinder = find.text('Terms & Privacy');

    //Then
    expect(termsPrivacyFinder, findsOneWidget);
  });
}