class StatsDto {
  final overallShopPerformance;
  final performanceByCategory;
  final salesByMonth;
  final deductionsByMonth;

  StatsDto(
      {required this.overallShopPerformance,
      required this.performanceByCategory,
      required this.salesByMonth,
      required this.deductionsByMonth,
      t});

  factory StatsDto.fromJson(Map<String, dynamic> json) {
    return StatsDto(
        overallShopPerformance: json['overallShopPerformance'],
        performanceByCategory: json['performanceByCategory'],
        salesByMonth: json['salesByMonth'],
        deductionsByMonth: json['deductionsByMonth']);
  }
}
