class EmailDto {
  final String topic;
  final String message;

  const EmailDto({
    required this.topic,
    required this.message,
  });

  Map<String, String> toJson(String email) {
    return {
      'Topic': topic,
      'Message': "$message\n\n- From $email",
    };
  }

  factory EmailDto.fromJson(Map<String, dynamic> json) {
    return EmailDto(
      topic: json['Topic'],
      message: json['Message'],
    );
  }
}
