class ReporteRequest {
  String id = '';
  String itemCode = '';
  String itemName = '';
  String typeItem = '';
  int quantity = 0;
  int price = 0;
  String createDate = '';

  ReporteRequest();

  ReporteRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    itemCode = json['ItemCode'];
    itemName = json['ItemName'];
    typeItem = json['TypeItem'];
    quantity = json['Quantity'];
    price = json['Price'];
    createDate = json['CreateDate'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'ItemCode': itemCode,
        'ItemName': itemName,
        'TypeItem': typeItem,
        'Quantity': quantity,
        'Price': price,
        'CreateDate': createDate,
      };
}
