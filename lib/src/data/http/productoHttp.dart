// ignore_for_file: file_names

import 'dart:convert';

import 'package:alegra_store/src/domain/repositories/producto_repositories.dart';

import '../../domain/requests/categoria_producto_request.dart';
import '../../domain/requests/producto_request.dart';
import '../env/Env.dart';
import 'package:http/http.dart' as http;

class ProductoHttp extends ProductoRepositories {
  @override
  Future<List<ProductoRequest>> listaProductos() async {
    final url = '${Env.rutaApi}/getProducts';

    print("dentra a poductos");

    try {
      final res = await http.post(
        Uri.parse(url),
      );

      print(res.body);

      if (res.statusCode == 200) {
        List serviceResponse = json.decode(res.body);
        return serviceResponse.map((e) => ProductoRequest.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<bool> registrarProducto(ProductoRequest producto) async {
    final url = '${Env.rutaApi}/products';

    var body = json.encode(producto.toJson());

    try {
      final res = await http.post(
        Uri.parse(url),
        body: body,
        headers: {"Content-Type": "application/json"},
      );

      print(body);

      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List<CategoriaProductoRequest>> listaCategoriaProductos() async {
    final url = '${Env.rutaApi}/categories';

    print("dentra a categorias");

    try {
      final res = await http.get(
        Uri.parse(url),
      );

      print(res.body);

      if (res.statusCode == 200) {
        List serviceResponse = json.decode(res.body);
        return serviceResponse
            .map((e) => CategoriaProductoRequest.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<List<ProductoRequest>> buscarProducto(String codeFiltro) async {
    final url = '${Env.rutaApi}/getProducts';

    print("dentra a buscar producto");

    final body = {
      "code": codeFiltro,
    };

    try {
      final res = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
      );

      if (res.statusCode == 200) {
        List serviceResponse = json.decode(res.body);
        return serviceResponse.map((e) => ProductoRequest.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> eliminarProducto(ProductoRequest producto) async {
    final url = '${Env.rutaApi}/products';

    var body = json.encode(producto.toJson());

    try {
      final res = await http.delete(
        Uri.parse(url),
        body: body,
        headers: {"Content-Type": "application/json"},
      );

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> actualizarProducto(ProductoRequest producto) async {
    final url = '${Env.rutaApi}/products';

    var body = json.encode(producto.toJson());

    try {
      final res = await http.put(
        Uri.parse(url),
        body: body,
        headers: {"Content-Type": "application/json"},
      );
      print("actualizar producto");
      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
