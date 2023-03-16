import '../services/reason_for_change_enum.dart';

class StockUpdateDTO {
  final String sku;
  final String? businessId;
  final int changeInStockAmount;
  final ReasonForChange reasonForChange;

  StockUpdateDTO(this.sku, this.businessId, this.changeInStockAmount,
      this.reasonForChange);
}
