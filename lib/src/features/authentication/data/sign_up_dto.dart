import 'dart:io';

class SignUpDto {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final File? imageFile;

  const SignUpDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.imageFile
  });

  Map<String, String> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }
}
