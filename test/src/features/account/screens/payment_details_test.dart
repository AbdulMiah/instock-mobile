import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/account/screens/payment_details.dart';

void main() {
  testWidgets('Payment Details screen has Payment Details heading', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: PaymentDetails()),
      ),
    );

    //When
    final paymentDetailsFinder = find.text('Payment Details');

    //Then
    expect(paymentDetailsFinder, findsOneWidget);
  });
}