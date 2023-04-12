import 'dart:io';

class SignUpDto {
  String firstName;

  String lastName;

  String email;

  String password;

  File? imageFile;

  SignUpDto(this.firstName, this.lastName, this.email, this.password);

  Map<String, String> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }
}
