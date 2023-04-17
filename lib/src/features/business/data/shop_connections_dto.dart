class ConnectionDto {
  final String platformName;
  final String authenticationToken;
  final String shopUsername;

  ConnectionDto({
    required this.platformName,
    required this.authenticationToken,
    required this.shopUsername,
  });

  factory ConnectionDto.fromJson(Map<String, dynamic> json) {
    return ConnectionDto(
      platformName: json['platformName'],
      authenticationToken: json['authenticationToken'],
      shopUsername: json['shopUsername'],
    );
  }
}
