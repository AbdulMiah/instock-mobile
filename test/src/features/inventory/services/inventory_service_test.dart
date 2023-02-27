import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/inventory/data/item.dart';
// import 'package:mocking/main.dart';
import 'package:instock_mobile/src/features/inventory/services/inventory_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../inventory_service_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  InventoryService inventoryService = InventoryService();
  group('getItems', () {
    test('returns items if http call completes successfully', () async {
      final client = MockClient();
      String url =
          "https://api.json-generator.com/templates/QqZmEQPf6dQR/data?access_token=token";

      when(client.get(Uri.parse(url))).thenAnswer((_) async => http.Response(
          '[{"SKU":"CRD-CKT-RLB","Name":"Birthday Cockatoo","Stock":"43","Category":"Cards","BusinessId":"2a36f726-b3a2-11ed-afa1-0242ac120002"},'
          '{"SKU":"CRD-BLK-KAL","Name":"Blank Koala","Stock":"5","Category":"Cards","BusinessId":"2a36f726-b3a2-11ed-afa1-0242ac120002"},'
          '{"SKU":"CRD-BIR-LAA","Name":"Birthday LLama","Stock":"35","Category":"Cards","BusinessId":"2a36f726-b3a2-11ed-afa1-0242ac120002"}]',
          200));

      expect(await inventoryService.getItems(client), isA<List<Item>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      String url =
          "https://api.json-generator.com/templates/QqZmEQPf6dQR/data?access_token=token";

      when(client.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(inventoryService.getItems(client), throwsException);
    });
  });
}
