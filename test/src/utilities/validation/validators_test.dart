import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/utilities/validation/validators.dart';

void main() {
  testWidgets(
      'Validate Password checks passwords are no longer than 32 characters',
      (tester) async {
    //Given
    String value = "AReallyReallyReallyReallyReallyReallyLongString44!";

    //When
    String? response = Validators.validatePassword(value);

    //Then
    expect(response,
        "Password must contain one capital letter, number and special character and have 8-32 characters");
  });

  testWidgets('Validate Password allows passwords shorter 32 characters',
      (tester) async {
    //Given
    String value = "AShortString44!";

    //When
    String? response = Validators.validatePassword(value);

    //Then
    expect(response, null);
  });

  testWidgets('Validate Password requires passwords to have 1 number',
      (tester) async {
    //Given
    String value = "AShortString!";

    //When
    String? response = Validators.validatePassword(value);

    //Then
    expect(response,
        "Password must contain one capital letter, number and special character and have 8-32 characters");
  });

  testWidgets(
      'Validate Password requires passwords to have 1 special character',
      (tester) async {
    //Given
    String value = "AShortString44";

    //When
    String? response = Validators.validatePassword(value);

    //Then
    expect(response,
        "Password must contain one capital letter, number and special character and have 8-32 characters");
  });

  testWidgets(
      'Validate Password requires passwords to have 1 upper case character',
      (tester) async {
    //Given
    String value = "ashortstring44!";

    //When
    String? response = Validators.validatePassword(value);

    //Then
    expect(response,
        "Password must contain one capital letter, number and special character and have 8-32 characters");
  });

  testWidgets(
      'Validate Password requires passwords to have 1 lower case character',
      (tester) async {
    //Given
    String value = "ASHORTSTRING44!";

    //When
    String? response = Validators.validatePassword(value);

    //Then
    expect(response,
        "Password must contain one capital letter, number and special character and have 8-32 characters");
  });

  testWidgets('isEmail blocks emails without @ sign', (tester) async {
    //Given
    String value = "archieemail.com";

    //When
    String? response = Validators.isEmail(value);

    //Then
    expect(response, "Invalid Email Format");
  });

  testWidgets('isEmail blocks emails without domain', (tester) async {
    //Given
    String value = "archie@email";

    //When
    String? response = Validators.isEmail(value);

    //Then
    expect(response, "Invalid Email Format");
  });

  testWidgets('isEmail blocks emails without name', (tester) async {
    //Given
    String value = "@email.com";

    //When
    String? response = Validators.isEmail(value);

    //Then
    expect(response, "Invalid Email Format");
  });

  testWidgets('isEmail allows valid emails', (tester) async {
    //Given
    String value = "archie@email.com";

    //When
    String? response = Validators.isEmail(value);

    //Then
    expect(response, null);
  });

  testWidgets('isEmail allows valid emails', (tester) async {
    //Given
    String value = "archie@email.com";

    //When
    String? response = Validators.isEmail(value);

    //Then
    expect(response, null);
  });

  testWidgets('notNull allows non null values', (tester) async {
    //Given
    String? value = "archie@email.com";

    //When
    String? response = Validators.notNull(value);

    //Then
    expect(response, null);
  });

  testWidgets('notNull throws an error for null values', (tester) async {
    //Given
    String? value;

    //When
    String? response = Validators.notNull(value);

    //Then
    expect(response, "This field is required");
  });

  testWidgets('notBlank throws an error for empty strings', (tester) async {
    //Given
    String? value = " ";

    //When
    String? response = Validators.notBlank(value);

    //Then
    expect(response, "This field is required");
  });

  testWidgets('notBlank allows strings with characters', (tester) async {
    //Given
    String? value = "Dawg";

    //When
    String? response = Validators.notBlank(value);

    //Then
    expect(response, null);
  });

  testWidgets('shortLength allows strings less than 50 characters',
      (tester) async {
    //Given
    String? value = "A short string";

    //When
    String? response = Validators.notBlank(value);

    //Then
    expect(response, null);
  });

  testWidgets('shortLength throws an error for strings over 50 characters',
      (tester) async {
    //Given
    // 51 characters long
    String? value = "Very very very very very very very very long string";

    //When
    String? response = Validators.shortLength(value);

    //Then
    expect(response, "Cannot be longer than 50 characters");
  });

  testWidgets('noNumbers characters allows standard name', (tester) async {
    //Given
    String? value = "RonnieColeman";

    //When
    String? response = Validators.noNumbers(value);

    //Then
    expect(response, null);
  });

  testWidgets('nameValidation characters allows Stephens Name', (tester) async {
    //Given
    String? value = "Stephen O'Keefe";

    //When
    String? response = Validators.nameValidation(value);

    //Then
    expect(response, null);
  });

  testWidgets('noNumbers characters does not allow numbers', (tester) async {
    //Givens
    String? value = "Stephen O'Keefe 555";

    //When
    String? response = Validators.noNumbers(value);

    //Then
    expect(response, "Can't have numbers");
  });

  testWidgets('nameValidation characters does not allow signs', (tester) async {
    //Given
    String? value = "Stephen O'Keefe ££";

    //When
    String? response = Validators.nameValidation(value);

    //Then
    expect(response,
        "Can't have special characters except hyphens, apostrophes and points");
  });

  testWidgets('nameValidation characters allows hyphenated names',
      (tester) async {
    //Given
    String? value = "Stephen O-Keefe";

    //When
    String? response = Validators.nameValidation(value);

    //Then
    expect(response, null);
  });

  testWidgets('nameValidation characters does not allow punctuation',
      (tester) async {
    //Given
    String? value = "Stephen O'Keefe !!!!!";

    //When
    String? response = Validators.nameValidation(value);

    //Then
    expect(response,
        "Can't have special characters except hyphens, apostrophes and points");
  });

  testWidgets(
      'noSpecialCharacters throws an error for strings with special characters',
      (tester) async {
    //Given
    String? value = "%^&!&";

    //When
    String? response = Validators.noSpecialCharacters(value);

    //Then
    expect(response, "No special characters");
  });

  testWidgets('noSpecialCharacters allows strings with no special characters',
      (tester) async {
    //Given
    String? value = "There are no special characters";

    //When
    String? response = Validators.noSpecialCharacters(value);

    //Then
    expect(response, null);
  });

  testWidgets('longLength throws an error for strings over 180 characters',
      (tester) async {
    //Given
    String? value = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. "
        "Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur rid";

    //When
    String? response = Validators.longLength(value);

    //Then
    expect(response, "Cannot be longer than 180 characters");
  });

  testWidgets('longLength allows strings less than 180 characters',
      (tester) async {
    //Given
    String? value = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.";

    //When
    String? response = Validators.longLength(value);

    //Then
    expect(response, null);
  });
}
