class ProductoRequest {
  String codigo = '';
  String nombre = '';
  String categoria = '';
  String fechaExpiracion = '';
  String fechaIngreso = '';
  int cantidad = 0;
  int peso = 0;
  String descripcion = '';
  int precioVenta = 0;
  int precioCompra = 0;
  int idCategory = 0;

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
    precioVenta = json['salePrice'] ?? 0;
    precioCompra = json['purchasePrice'] ?? 0;
    idCategory = json['idCategory'] ?? 0;
  }

  Map<String, dynamic> toJson() => {
        'code': codigo,
        'name': nombre,
        'idCategory': idCategory,
        "categoryName": categoria,
        'weight': peso,
        'quantity': cantidad,
        'purchasePrice': precioCompra,
        'salePrice': precioVenta,
        'entryDate': fechaIngreso,
        'expirationDate': fechaExpiracion,
        'description': descripcion,
      };
}
