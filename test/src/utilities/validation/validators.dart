import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/utilities/validation/validators.dart';

void main() {
  testWidgets(
      'Validate Password checks passwords are no longer than 30 characters',
      (tester) async {
    //Given
    String value = "AReallyReallyReallyReallyReallyReallyLongString";

    //When
    String? response = Validators.validatePassword(value);

    //Then
    expect(response, "Cannot be longer than 30 characters");
  });

  testWidgets('Validate Password allows passwords shorter 30 characters',
      (tester) async {
    //Given
    String value = "AShortString";

    //When
    String? response = Validators.validatePassword(value);

    //Then
    expect(response, null);
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
    String? value = null;

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

  testWidgets('noSpecial characters allows standard name', (tester) async {
    //Given
    String? value = "RonnieColeman";

    //When
    String? response = Validators.noSpecialCharacters(value);

    //Then
    expect(response, null);
  });

  testWidgets('noSpecial characters allows Stephens Name', (tester) async {
    //Given
    String? value = "Stephen O'Keefe";

    //When
    String? response = Validators.noSpecialCharacters(value);

    //Then
    expect(response, null);
  });

  testWidgets('noSpecial characters does not allow numbers', (tester) async {
    //Given
    String? value = "Stephen O'Keefe 555";

    //When
    String? response = Validators.noSpecialCharacters(value);

    //Then
    expect(response, "Can't have numbers and special characters");
  });

  testWidgets('noSpecial characters does not allow special characters',
      (tester) async {
    //Given
    String? value = "Stephen O'Keefe ££";

    //When
    String? response = Validators.noSpecialCharacters(value);

    //Then
    expect(response, "Can't have numbers and special characters");
  });

  testWidgets('noSpecial characters allows hyphenated names', (tester) async {
    //Given
    String? value = "Stephen O-Keefe";

    //When
    String? response = Validators.noSpecialCharacters(value);

    //Then
    expect(response, null);
  });

  testWidgets('noSpecial characters does not allow punctuation',
      (tester) async {
    //Given
    String? value = "Stephen O'Keefe !!!!!";

    //When
    String? response = Validators.noSpecialCharacters(value);

    //Then
    expect(response, "Can't have numbers and special characters");
  });
}
