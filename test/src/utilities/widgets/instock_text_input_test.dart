import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';
import 'package:instock_mobile/src/utilities/validation/validators.dart';
import 'package:instock_mobile/src/utilities/widgets/instock_text_input.dart';

void main() {
  testWidgets('Form Field Renders with given Text', (tester) async {
    //Given
    CommonTheme commonTheme = CommonTheme();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: InStockTextInput(
          text: 'Test Input',
          theme: commonTheme.themeData,
          icon: null,
          validators: const [],
          onSaved: (string) {},
        )),
      ),
    );

    //When
    final textInputFinder = find.byType(TextField);
    final inputLabelFind = find.text("Test Input");

    //Then
    expect(textInputFinder, findsOneWidget);
    expect(inputLabelFind, findsOneWidget);
  });

  testWidgets('Input displays given icon', (tester) async {
    //Given
    CommonTheme commonTheme = CommonTheme();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: InStockTextInput(
          text: 'Test Input',
          theme: commonTheme.themeData,
          icon: Icons.ice_skating_sharp,
          validators: const [],
          onSaved: (string) {},
        )),
      ),
    );

    //When
    final iconFinder = find.byIcon(Icons.ice_skating_sharp);

    //Then
    expect(iconFinder, findsOneWidget);
  });

  testWidgets('Input validators catch errors', (tester) async {
    //Given
    CommonTheme commonTheme = CommonTheme();
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Form(
          key: formKey,
          child: InStockTextInput(
            text: 'Test Input',
            theme: commonTheme.themeData,
            icon: null,
            validators: const [
              Validators.notNull,
              Validators.notBlank,
              Validators.validatePassword,
            ],
            onSaved: (string) {},
          ),
        )),
      ),
    );

    //When
    formKey.currentState!.validate();
    await tester.pumpAndSettle();
    final textFinder = find.text("This field is required");

    //Then
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Input onSave is callable', (tester) async {
    //Given
    bool pressed = false;
    testMethod() {
      pressed = true;
    }

    CommonTheme commonTheme = CommonTheme();
    final formKey0 = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: Form(
          key: formKey0,
          child: InStockTextInput(
            text: 'Test Input',
            theme: commonTheme.themeData,
            icon: null,
            validators: const [],
            onSaved: (string) {
              testMethod();
            },
          ),
        )),
      ),
    );

    //When
    formKey0.currentState!.save();
    await tester.pumpAndSettle();

    //Then
    expect(pressed, true);
  });

// Validators work
}
