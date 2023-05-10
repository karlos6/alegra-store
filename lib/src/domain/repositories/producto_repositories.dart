import 'package:alegra_store/src/domain/requests/categoria_producto_request.dart';
import 'package:alegra_store/src/domain/requests/producto_request.dart';

abstract class ProductoRepositories {
  Future<List<ProductoRequest>> listaProductos();
  Future<List<CategoriaProductoRequest>> listaCategoriaProductos();
  Future<bool> registrarProducto(ProductoRequest producto);
  Future<List<ProductoRequest>> buscarProducto(String nombre);
  Future<bool> eliminarProducto(ProductoRequest producto);
  Future<bool> actualizarProducto(ProductoRequest producto);
}
