class ReporteVentasRequest {
  String code = '';
  String name = '';
  int soldQuantity = 0;
  int purchasePrice = 0;
  int salePrice = 0;
  int profit = 0;

  ReporteVentasRequest();

  ReporteVentasRequest.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? '';
    name = json['name'] ?? '';
    soldQuantity = json['soldQuantity'] ?? 0;
    purchasePrice = json['purchasePrice'] ?? 0;
    salePrice = json['salePrice'] ?? 0;
    profit = json['profit'] ?? 0;
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'soldQuantity': soldQuantity,
        'purchasePrice': purchasePrice,
        'salePrice': salePrice,
        'profit': profit,
      };
}
