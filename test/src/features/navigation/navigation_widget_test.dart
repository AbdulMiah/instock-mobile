import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/navigation/navigation_bar.dart';

void main() {
  testWidgets('Navigation bar has correct labels', (tester) async {
    await tester.pumpWidget(const NavBar());

    final homeFinder = find.text('Home');
    final statsFinder = find.text('Stats');
    final addItemFinder = find.text('Add Item');
    final businessFinder = find.text('Business');
    final accountFinder = find.text('Account');

    expect(homeFinder, findsOneWidget);
    expect(statsFinder, findsOneWidget);
    expect(addItemFinder, findsOneWidget);
    expect(businessFinder, findsOneWidget);
    expect(accountFinder, findsOneWidget);
  });

  testWidgets('Defaults to Home tab', (tester) async {
    await tester.pumpWidget(const NavBar());
    final inventoryFinder = find.text('Inventory');

    expect(inventoryFinder, findsOneWidget);
  });

  testWidgets('Other tabs are hidden', (tester) async {
    await tester.pumpWidget(const NavBar());

    final statsFinder = find.text('Stats');
    final addItemFinder = find.text('Add Item');
    final businessFinder = find.text('Business');
    final accountFinder = find.text('Account');

    expect(statsFinder, isNot(findsAtLeastNWidgets(2)));
    expect(addItemFinder, isNot(findsAtLeastNWidgets(2)));
    expect(businessFinder, isNot(findsAtLeastNWidgets(2)));
    expect(accountFinder, isNot(findsAtLeastNWidgets(2)));
  });

  testWidgets('Method is called on button press', (tester) async {
    //Given
    await tester.pumpWidget(const NavBar());
    await tester.pump(const Duration(seconds: 5));

    final statsFinder = find.text('Stats');

    expect(statsFinder, findsOneWidget);

    //When
    await tester.tap(statsFinder);
    await tester.pumpAndSettle();
    //Then
    expect(statsFinder, findsAtLeastNWidgets(2));
  });
}
