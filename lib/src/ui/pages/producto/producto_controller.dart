// ignore_for_file: use_build_context_synchronously

import 'package:alegra_store/src/domain/requests/categoria_producto_request.dart';
import 'package:alegra_store/src/domain/requests/producto_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../../data/http/ProductoHttp.dart';
import '../../utilities/mensajesAlerta.dart';

class ProductoController {
  ProductoHttp productoHttp = ProductoHttp();

  Future<List<ProductoRequest>> listarProductos() async {
    return await productoHttp.listaProductos();
  }

  Future<List<CategoriaProductoRequest>> listarCategoriaProductos() async {
    return await productoHttp.listaCategoriaProductos();
  }

  Future registrarProducto(
      BuildContext context, ProductoRequest producto) async {
    bool verificar = await productoHttp.registrarProducto(producto);

    if (verificar) {
      creadoExitoso(
          context, "La producto se registro correctamente", 'lista_articulo');
    } else {
      mensajeAlerta(
          context, "Error al registrar el producto", "No se pudo registrar");
    }
    return verificar;
  }

  Future<List<ProductoRequest>> buscarProducto(String nombre) async {
    return await productoHttp.buscarProducto(nombre);
  }

  Future<bool> eliminarProducto(
    BuildContext context,
    ProductoRequest producto,
  ) async {
    bool verificar = await productoHttp.eliminarProducto(producto);
    if (verificar) {
      mensajeAlerta(context, "Producto eliminado correctamente",
          "Se elimino correctamente");
    } else {
      mensajeAlerta(
          context, "Error al eliminar el producto", "No se pudo eliminar");
    }
    return verificar;
  }

  Future<String> leerCodigoDeBarras(BuildContext context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#3D8BEF', 'Cancelar', false, ScanMode.BARCODE);

    if (barcodeScanRes == "-1") {
      return "";
    }
    print("Codigo de barras: ");
    print(barcodeScanRes);
    return barcodeScanRes;
  }

  Future actualizarProducto(
      BuildContext context, ProductoRequest producto) async {
    bool verificar = await productoHttp.actualizarProducto(producto);

    if (verificar) {
      creadoExitoso(
          context, "La producto se actualizó correctamente", 'lista_articulo');
    } else {
      mensajeAlerta(
          context, "Error al actualizar el producto", "No se pudo actualizar");
    }
    return verificar;
  }
}
