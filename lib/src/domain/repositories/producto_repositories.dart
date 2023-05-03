import 'package:alegra_store/src/domain/requests/producto_request.dart';

abstract class ProductoRepositories {
  Future<List<ProductoRequest>> listaProductos();
  Future<List<String>> tipoProductos();
  Future<bool> registrarProducto(ProductoRequest producto);
}
