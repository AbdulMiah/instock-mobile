import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/utilities/widgets/photo_picker.dart';

void main() {
  testWidgets('Circular avatar renders', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PhotoPicker(),
        ),
      ),
    );

    //When
    final iconFinder = find.byIcon(Icons.image_not_supported_outlined);

    //Then
    expect(iconFinder, findsOneWidget);
  });

  testWidgets('Camera button renders', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PhotoPicker(),
        ),
      ),
    );

    //When
    final iconFinder = find.byIcon(Icons.camera_alt_outlined);

    //Then
    expect(iconFinder, findsOneWidget);
  });

  testWidgets('Modal bottom sheet is displayed when camera button is pressed', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PhotoPicker(),
        ),
      ),
    );

    //When
    final iconFinder = find.byIcon(Icons.camera_alt_outlined);
    await tester.tap(iconFinder);
    await tester.pumpAndSettle();
    final galleryFinder = find.text('Choose from Gallery');
    final cameraFinder = find.text('Take a Photo');

    //Then
    expect(galleryFinder, findsOneWidget);
    expect(cameraFinder, findsOneWidget);
  });
}