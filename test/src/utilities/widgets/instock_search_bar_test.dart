import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';
import 'package:instock_mobile/src/utilities/widgets/instock_search_bar.dart';

void main() {
  testWidgets('Search bar Renders with given Text', (tester) async {
    //Given
    CommonTheme commonTheme = CommonTheme();
    TextEditingController editingController = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: InStockSearchBar(
              text: 'Search',
              theme: commonTheme.themeData,
              controller: editingController,
            )),
      ),
    );

    //When
    final searchInputFinder = find.byType(TextField);
    final searchLabelFind = find.text("Search");

    //Then
    expect(searchInputFinder, findsOneWidget);
    expect(searchLabelFind, findsOneWidget);
  });

  testWidgets('Input displays default icon', (tester) async {
    //Given
    CommonTheme commonTheme = CommonTheme();
    TextEditingController editingController = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: InStockSearchBar(
              text: 'Search',
              theme: commonTheme.themeData,
              controller: editingController,
            )),
      ),
    );

    //When
    final iconFinder = find.byIcon(Icons.search);

    //Then
    expect(iconFinder, findsOneWidget);
  });

  testWidgets('Input displays given icon', (tester) async {
    //Given
    CommonTheme commonTheme = CommonTheme();
    TextEditingController editingController = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: InStockSearchBar(
              text: 'Search',
              theme: commonTheme.themeData,
              controller: editingController,
              icon: Icons.print,
            )),
      ),
    );

    //When
    final iconFinder = find.byIcon(Icons.print);

    //Then
    expect(iconFinder, findsOneWidget);
  });
}
