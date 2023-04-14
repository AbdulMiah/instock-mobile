class LoginDto {
  final String email;
  final String password;

  const LoginDto({
    required this.email,
    required this.password,
  });

  Map<String, String> toJson(String deviceToken) {
    return {
      'Email': email,
      'Password': password,
      'DeviceToken': deviceToken
    };
  }
}