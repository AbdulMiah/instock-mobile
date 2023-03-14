import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/authentication/screens/sign_up_page.dart';
import 'package:instock_mobile/src/utilities/validation/validators.dart';
import 'package:instock_mobile/src/utilities/widgets/instock_button.dart';
import 'package:instock_mobile/src/utilities/widgets/instock_text_input.dart';

///
void main() {
  testWidgets('Sign Up screen Renders', (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SignUp()),
      ),
    );

    //When
    final loginFinder = find.text('Sign Up');

    //Then
    expect(loginFinder, findsNWidgets(2));
  });

  testWidgets('Sign Up has all fields needed for user to register',
      (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SignUp()),
      ),
    );

    const firstName = Key('firstNameTextField');
    const lastName = Key('lastNameTextField');
    const email = Key('emailTextField');
    const password = Key('passwordTextField');

    final firstNameField =
        tester.widget<InStockTextInput>(find.byKey(firstName));
    final lastNameField = tester.widget<InStockTextInput>(find.byKey(lastName));
    final emailField = tester.widget<InStockTextInput>(find.byKey(email));
    final passwordField = tester.widget<InStockTextInput>(find.byKey(password));

    expect(firstNameField.text, 'First Name');
    expect(lastNameField.text, 'Last Name');
    expect(emailField.text, 'Email');
    expect(passwordField.text, 'Password');
  });

  testWidgets(
      'Sign Up first name is not null, short, has no numbers and allows name validation ',
      (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SignUp()),
      ),
    );

    const firstName = Key('firstNameTextField');

    final firstNameField =
        tester.widget<InStockTextInput>(find.byKey(firstName));

    expect(firstNameField.validators, [
      Validators.notNull,
      Validators.notBlank,
      Validators.shortLength,
      Validators.noNumbers,
      Validators.nameValidation,
    ]);
  });

  testWidgets(
      'Sign Up last name is not null, short, has no numbers and allows name validation',
      (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SignUp()),
      ),
    );

    const lastName = Key('firstNameTextField');

    final lastNameField = tester.widget<InStockTextInput>(find.byKey(lastName));

    expect(lastNameField.validators, [
      Validators.notNull,
      Validators.notBlank,
      Validators.shortLength,
      Validators.noNumbers,
      Validators.nameValidation,
    ]);
  });

  testWidgets('Sign Up email is not null, not blank and is valid',
      (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SignUp()),
      ),
    );

    const email = Key('emailTextField');

    final emailField = tester.widget<InStockTextInput>(find.byKey(email));

    expect(emailField.validators, [
      Validators.notNull,
      Validators.notBlank,
      Validators.isEmail,
    ]);
  });

  testWidgets('Sign Up password is not null, not blank and is valid',
      (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SignUp()),
      ),
    );

    const password = Key('passwordTextField');

    final passwordField = tester.widget<InStockTextInput>(find.byKey(password));

    expect(passwordField.validators, [
      Validators.notNull,
      Validators.notBlank,
      Validators.validatePassword,
    ]);
  });

  testWidgets('Sign Up confirm password is not null, not blank and is valid',
      (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SignUp()),
      ),
    );

    const confirmPassword = Key('confirmPasswordTextField');

    final confirmPasswordField =
        tester.widget<InStockTextInput>(find.byKey(confirmPassword));

    expect(confirmPasswordField.validators, [
      Validators.notNull,
      Validators.notBlank,
      Validators.validatePassword,
    ]);
  });

  testWidgets('Sign Up has submit button', (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SignUp()),
      ),
    );

    const signUp = Key('signUpButton');
    final signUpButton = tester.widget<InStockButton>(find.byKey(signUp));

    expect(signUpButton.text, "Sign Up");
  });
}
