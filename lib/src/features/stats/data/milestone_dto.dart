class MilestoneDto {
  String milestoneId;
  String businessId;
  String itemSku;
  String itemName;
  String imageUrl;
  int totalSales;
  int dateTime;
  bool displayMilestone;

  MilestoneDto({
    required this.milestoneId,
    required this.businessId,
    required this.itemSku,
    required this.itemName,
    required this.imageUrl,
    required this.totalSales,
    required this.dateTime,
    required this.displayMilestone,
  });

  factory MilestoneDto.fromJson(Map<String, dynamic> json) {
    return MilestoneDto(
      milestoneId: json['MilestoneId'],
      businessId: json['BusinessId'],
      itemSku: json['ItemSku'],
      itemName: json['ItemName'],
      imageUrl: json['ImageUrl'],
      totalSales: json['TotalSales'],
      dateTime: json['DateTime'],
      displayMilestone: json['DisplayMilestone'],
    );
  }
}
