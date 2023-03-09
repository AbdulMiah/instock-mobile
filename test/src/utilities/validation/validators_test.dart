import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/utilities/validation/validators.dart';

void main() {
  testWidgets(
      'Validate Password checks passwords are no longer than 20 characters',
      (tester) async {
    //Given
    String value = "AReallyReallyReallyReallyReallyReallyLongString";

    //When
    String? response = Validators.validatePassword(value);

    //Then
    expect(response, "Cannot be longer than 20 characters");
  });

  testWidgets('Validate Password allows passwords shorter 20 characters',
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

  testWidgets('shortLength allows strings less than 30 characters',
      (tester) async {
    //Given
    String? value = "A short string";

    //When
    String? response = Validators.notBlank(value);

    //Then
    expect(response, null);
  });

  testWidgets('shortLength throws an error for strings over 30 characters',
      (tester) async {
    //Given
    String? value = "A very very very very very very very very"
        "very very very long string";

    //When
    String? response = Validators.shortLength(value);

    //Then
    expect(response, "Cannot be longer than 30 characters");
  });

  testWidgets('noSpecialChars throws an error for strings with special characters',
          (tester) async {
    //Given
    String? value = "%^&!&";

    //When
    String? response = Validators.noSpecialChars(value);

    //Then
    expect(response, "No special characters");
  });

  testWidgets('noSpecialChars allows strings with no special characters',
          (tester) async {
    //Given
    String? value = "There are no special characters";

    //When
    String? response = Validators.noSpecialChars(value);

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

  testWidgets('longLength allows strings less than 180 characters', (tester) async {
    //Given
    String? value = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.";

    //When
    String? response = Validators.longLength(value);

    //Then
    expect(response, null);
  });
}
