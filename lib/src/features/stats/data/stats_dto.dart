class StatsDto {
  final overallShopPerformance;
  final categoryStats;
  final salesByMonth;
  final deductionsByMonth;
  final suggestions;

  StatsDto(
      {required this.overallShopPerformance,
      required this.categoryStats,
      required this.salesByMonth,
      required this.deductionsByMonth,
      required this.suggestions});

  factory StatsDto.fromJson(Map<String, dynamic> json) {
    return StatsDto(
        overallShopPerformance: json['overallShopPerformance'],
        categoryStats: json['categoryStats'],
        salesByMonth: json['salesByMonth'],
        deductionsByMonth: json['deductionsByMonth'],
        suggestions: json['suggestions']);
  }

  @override
  String toString() {
    return 'StatsDto{overallShopPerformance: $overallShopPerformance, categoryStats: $categoryStats, salesByMonth: $salesByMonth, deductionsByMonth: $deductionsByMonth, suggestions: $suggestions}';
  }
}
