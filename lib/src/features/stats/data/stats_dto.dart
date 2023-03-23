class StatsDto {
  final Map<String, int> overallShopPerformance;
  final performanceByCategory;
  final Map<String, int> salesByMonth;
  final Map<String, int> deductionsByMonth;

  StatsDto(
      {required this.overallShopPerformance,
      required this.performanceByCategory,
      required this.salesByMonth,
      required this.deductionsByMonth,
      t});
}
