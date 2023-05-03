class ProductoRequest {
  String codigo = '';
  String nombre = '';
  String categoria = '';
  String fechaExpiracion = '';
  String fechaIngreso = '';
  int cantidad = 0;
  int peso = 0;
  String descripcion = '';

  //int precio = 0;

  ProductoRequest();

  ProductoRequest.fromJson(Map<String, dynamic> json) {
    codigo = json['code'] ?? '';
    nombre = json['name'] ?? '';
    categoria = json['categoryName'] ?? '';
    peso = json['weight'] ?? 0;
    cantidad = json['quantity'] ?? 0;
    fechaIngreso = json['entryDate'] ?? '';
    fechaExpiracion = json['expirationDate'] ?? '';
    descripcion = json['description'] ?? '';
    //precio = json['Price'] ?? 0;
  }

  Map<String, dynamic> toJson() => {
        'code': codigo,
        'name': nombre,
        'categoryName': categoria,
        'quantity': cantidad,
        'expirationDate': fechaExpiracion,
        'entryDate': fechaIngreso,
        'weight': peso,
        'description': descripcion,
        //'Price': precio,
      };
}
