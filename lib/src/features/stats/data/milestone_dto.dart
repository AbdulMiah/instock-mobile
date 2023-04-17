import '../../../utilities/data/error_notification.dart';

class MilestoneDto {
  String milestoneId;
  String businessId;
  String itemSku;
  String itemName;
  String? imageUrl;
  String? imageFilename;
  int totalSales;
  int dateTime;
  bool displayMilestone;
  ErrorNotification? errorNotificationDto;

  MilestoneDto({
    required this.milestoneId,
    required this.businessId,
    required this.itemSku,
    required this.itemName,
    required this.imageUrl,
    required this.totalSales,
    required this.dateTime,
    required this.displayMilestone,
    required this.errorNotificationDto,
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
      errorNotificationDto: json['ErrorNotification'] != null
          ? ErrorNotification.fromJson(json['ErrorNotification'])
          : null,
    );
  }

  // The hide milestone endpoint returns a json with lowercase keys
  factory MilestoneDto.fromJsonPost(Map<String, dynamic> json) {
    String? imageUrlJson = json['imageUrl'];
    if (imageUrlJson == null || imageUrlJson == '') {
      imageUrlJson = null;
    }

    return MilestoneDto(
      milestoneId: json['milestoneId'],
      businessId: json['businessId'],
      itemSku: json['itemSku'],
      itemName: json['itemName'],
      imageUrl: imageUrlJson,
      totalSales: json['totalSales'],
      dateTime: json['dateTime'],
      displayMilestone: json['displayMilestone'],
      errorNotificationDto: json['errorNotification'] != null
          ? ErrorNotification.fromJson(json['errorNotification'])
          : null,
    );
  }
}
