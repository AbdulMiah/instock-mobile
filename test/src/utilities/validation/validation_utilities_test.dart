import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/utilities/validation/validator_utilities.dart';

void main() {
  testWidgets(
      'Validation Utilities Max Length Returns error if above max length',
      (tester) async {
    //Given
    ValidatorUtilities validatorUtilities = ValidatorUtilities();
    String value = "TestValue";
    int maxLength = 5;

    //When
    String? response = validatorUtilities.maxLength(value, maxLength);

    //Then
    expect(response, "Cannot be longer than $maxLength characters");
  });

  testWidgets(
      'Validation Utilities Max Length Returns null if below max length',
      (tester) async {
    //Given
    ValidatorUtilities validatorUtilities = ValidatorUtilities();
    String value = "TestValue";
    int maxLength = 15;

    //When
    String? response = validatorUtilities.maxLength(value, maxLength);

    //Then
    expect(response, null);
  });

  testWidgets(
      'Validation Utilities Min Length Returns error if below min length',
      (tester) async {
    //Given
    ValidatorUtilities validatorUtilities = ValidatorUtilities();
    String value = "Short";
    int minLength = 8;

    //When
    String? response = validatorUtilities.minLength(value, minLength);

    //Then
    expect(response, "Cannot be shorter than $minLength characters");
  });

  testWidgets(
      'Validation Utilities Min Length Returns null if above min length',
      (tester) async {
    //Given
    ValidatorUtilities validatorUtilities = ValidatorUtilities();
    String value = "Short";
    int minLength = 4;

    //When
    String? response = validatorUtilities.minLength(value, minLength);

    //Then
    expect(response, null);
  });
}
