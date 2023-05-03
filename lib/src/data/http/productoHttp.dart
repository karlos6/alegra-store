// ignore_for_file: file_names

import 'dart:convert';

import 'package:alegra_store/src/domain/repositories/producto_repositories.dart';

import '../../domain/requests/producto_request.dart';
import '../env/Env.dart';
import 'package:http/http.dart' as http;

class ProductoHttp extends ProductoRepositories {
  @override
  Future<List<ProductoRequest>> listaProductos() async {
    final url = '${Env.rutaApi}/products';

    print("dentra a poductos");

    try {
      final res = await http.get(
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

    try {
      final res = await http.post(
        Uri.parse(url),
        body: json.encode(producto.toJson()),
      );

      print(res);

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
  Future<List<String>> tipoProductos() {
    // TODO: implement tipoProductos
    throw UnimplementedError();
  }
}
