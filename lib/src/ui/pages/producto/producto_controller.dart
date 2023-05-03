import 'package:alegra_store/src/domain/requests/producto_request.dart';

import '../../../data/http/ProductoHttp.dart';

class ProductoController {
  ProductoHttp productoHttp = ProductoHttp();

  Future<List<ProductoRequest>> listarProductos() async {
    return await productoHttp.listaProductos();
  }
}
