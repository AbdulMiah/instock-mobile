import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/authentication/screens/login_page.dart';
import 'package:instock_mobile/src/features/authentication/services/authentication_service.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

void main() {
  testWidgets('Login screen has Login text and button', (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Login()),
      ),
    );

    //When
    final loginFinder = find.text('Login');

    //Then
    expect(loginFinder, findsNWidgets(2));
  });

  testWidgets('Login screen has Email field', (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Login()),
      ),
    );

    //When
    final emailFinder = find.text('Email');

    //Then
    expect(emailFinder, findsOneWidget);
  });

  testWidgets('Login screen has Password field', (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Login()),
      ),
    );

    //When
    final passwordFinder = find.text('Password');

    //Then
    expect(passwordFinder, findsOneWidget);
  });
}
//  Requires dependency injection
//   testWidgets('User redirected to home when logged in successfully',
//       (tester) async {
//     //Given
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(body: Login()),
//       ),
//     );
//
//     ResponseObject responseObject = ResponseObject(200, "Success");
//
//     var auth = MockAuthenticationService();
//     when(auth.authenticateUser('john@gmail.com', 'Test123'))
//         .thenReturn(responseObject as Future<ResponseObject>);
//
//     //When
//     final response = await auth.authenticateUser('john@gmail.com', 'Test123');
//
//     //Then
//     expect(response.statusCode, 200);
//   });
// }

//Mock successful login
//Mock auth service
//invalid email - error message pops up
//no password - error message pops up

// void main() {
//   // Create a new mocked Cat at runtime.
//   var cat = new MockCat();
//
//   // When 'getSound' is called, return 'Woof'
//   when(cat.getSound(any)).thenReturn('Woof');
//
//   // Try making a Cat sound...
//   print(cat.getSound('foo')); // Prints 'Woof'
// }
