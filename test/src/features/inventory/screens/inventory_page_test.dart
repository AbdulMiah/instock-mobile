import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/inventory/screens/inventory_page.dart';
import 'package:mockito/mockito.dart';

import '../services/inventory_service_test.mocks.dart';

void main() {
  testWidgets('Page has correct heading', (tester) async {
    final client = MockClient();
    String url = "api.instockinventory.co.uk";

    when(client.get(Uri.parse(url))).thenAnswer((_) async => http.Response(
        '[{"SKU":"CRD-CKT-RLB","Name":"Birthday Cockatoo","Stock":"43","Category":"Cards","BusinessId":"2a36f726-b3a2-11ed-afa1-0242ac120002"},'
        '{"SKU":"CRD-BLK-KAL","Name":"Blank Koala","Stock":"5","Category":"Cards","BusinessId":"2a36f726-b3a2-11ed-afa1-0242ac120002"},'
        '{"SKU":"CRD-BIR-LAA","Name":"Birthday LLama","Stock":"35","Category":"Cards","BusinessId":"2a36f726-b3a2-11ed-afa1-0242ac120002"}]',
        200));

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Inventory()),
      ),
    );

    final headingFinder = find.text('Inventory');

    expect(headingFinder, findsOneWidget);
  });
}
