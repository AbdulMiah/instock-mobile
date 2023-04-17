class AddShopConnectionDto {
  final String platformName;
  final String shopUsername;
  final String shopUserPassword;

  AddShopConnectionDto({
    required this.platformName,
    required this.shopUsername,
    required this.shopUserPassword,
  });

  Map<String, dynamic> toJson() => {
        'PlatformNameConnectingTo': platformName,
        'ShopUsername': shopUsername,
        'ShopUserPassword': shopUserPassword,
      };
}
