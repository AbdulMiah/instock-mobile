class UserDto {
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;

  const UserDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl
  });

  Map<String, String> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      imageUrl: json['imageUrl']
    );
  }
}
