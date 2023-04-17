import '../../../utilities/data/error_notification.dart';

class MilestoneDto {
  String milestoneId;
  String businessId;
  String itemSku;
  String itemName;
  String? imageUrl;
  int totalSales;
  int dateTime;
  bool displayMilestone;
  ErrorNotification? errorNotificationDto;

  MilestoneDto({
    required this.milestoneId,
    required this.businessId,
    required this.itemSku,
    required this.itemName,
    this.imageUrl,
    required this.totalSales,
    required this.dateTime,
    required this.displayMilestone,
    this.errorNotificationDto,
  });

  factory MilestoneDto.fromJson(Map<String, dynamic> json) {
    String? imageUrlJson = json['ImageUrl'];
    if (imageUrlJson == null || imageUrlJson == '') {
      imageUrlJson = null;
    }
    return MilestoneDto(
      milestoneId: json['MilestoneId'],
      businessId: json['BusinessId'],
      itemSku: json['ItemSku'],
      itemName: json['ItemName'],
      imageUrl: imageUrlJson,
      totalSales: json['TotalSales'],
      dateTime: json['DateTime'],
      displayMilestone: json['DisplayMilestone'],
      errorNotificationDto: json['ErrorNotificationDto'] != null
          ? ErrorNotification.fromJson(json['ErrorNotificationDto'])
          : null,
    );
  }
}
