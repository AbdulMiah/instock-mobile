import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/business/widgets/shop_connection_card.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ShopConnectionCard displays correct title and description',
      (WidgetTester tester) async {
    const title = 'InStock';
    const imageUrl = 'image at url';
    const description =
        'imaging at imaging.com. This is a description of the shop';
    const connected = false;

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShopConnectionCard(
              title: title,
              imageUrl: imageUrl,
              description: description,
              connected: connected,
              onConnectionChanged: (bool connected) {},
            ),
          ),
        ),
      );

      var titleFinder = find.text(title);
      var descriptionFinder = find.text(description);

      expect(titleFinder, findsOneWidget);
      expect(descriptionFinder, findsOneWidget);
    });
  });

  testWidgets('ShopConnectionCard displays connected when connected is true',
      (WidgetTester tester) async {
    const title = 'InStock';
    const imageUrl = 'image at url';
    const description =
        'imaging at imaging.com. This is a description of the shop';
    const connected = true;

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShopConnectionCard(
              title: title,
              imageUrl: imageUrl,
              description: description,
              connected: connected,
              onConnectionChanged: (bool connected) {},
            ),
          ),
        ),
      );

      var connectedFinder = find.text("Connected");

      expect(connectedFinder, findsOneWidget);
    });
  });

  testWidgets('ShopConnectionCard displays connect when connected is false',
      (WidgetTester tester) async {
    const title = 'InStock';
    const imageUrl = 'image at url';
    const description =
        'imaging at imaging.com. This is a description of the shop';
    const connected = false;

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShopConnectionCard(
              title: title,
              imageUrl: imageUrl,
              description: description,
              connected: connected,
              onConnectionChanged: (bool connected) {},
            ),
          ),
        ),
      );

      var connectedFinder = find.text("Connect");

      expect(connectedFinder, findsOneWidget);
    });
  });

  testWidgets('ShopConnectionCard displays sign in when connect is clicked',
      (WidgetTester tester) async {
    const title = 'InStock';
    const imageUrl = 'image at url';
    const description =
        'imaging at imaging.com. This is a description of the shop';
    const connected = false;

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShopConnectionCard(
              title: title,
              imageUrl: imageUrl,
              description: description,
              connected: connected,
              onConnectionChanged: (bool connected) {},
            ),
          ),
        ),
      );

      var connectedFinder = find.text("Connect");

      await tester.tap(connectedFinder);
      await tester.pumpAndSettle();

      var signInFinder = find.text("Sign In To InStock");

      expect(signInFinder, findsOneWidget);
    });
  });

  testWidgets('ShopConnectionCard displays alert when connected is clicked',
      (WidgetTester tester) async {
    const title = 'InStock';
    const imageUrl = 'image at url';
    const description =
        'imaging at imaging.com. This is a description of the shop';
    const connected = true;

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShopConnectionCard(
              title: title,
              imageUrl: imageUrl,
              description: description,
              connected: connected,
              onConnectionChanged: (bool connected) {},
            ),
          ),
        ),
      );

      var connectedFinder = find.text("Connected");

      await tester.tap(connectedFinder);
      await tester.pumpAndSettle();

      var alreadyConnectedFinder =
          find.text("You are already connected to InStock");

      expect(alreadyConnectedFinder, findsOneWidget);
    });
  });
}
