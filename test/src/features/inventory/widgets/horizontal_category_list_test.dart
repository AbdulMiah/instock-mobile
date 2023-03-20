import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/inventory/widgets/horizontal_category_list.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  testWidgets('Displays Category', (tester) async {
    // Given
    final controller = ItemScrollController();
    Map<String, int> testCategories = {
      'Bookmarks': 1,
      'Cards': 2,
      'Stickers': 3
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HorizontalCategoryList(categories: testCategories, scrollController: controller,),
        ),
      ),
    );

    // When
    final bookmarksFinder = find.text('Bookmarks');
    final cardsFinder = find.text('Cards');
    final stickersFinder = find.text('Stickers');

    // Then
    expect(bookmarksFinder, findsOneWidget);
    expect(cardsFinder, findsOneWidget);
    expect(stickersFinder, findsOneWidget);
  });
}
