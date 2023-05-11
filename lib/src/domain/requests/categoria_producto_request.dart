class CategoriaProductoRequest {
  String id = "";
  String name = "";

  CategoriaProductoRequest();

  CategoriaProductoRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
