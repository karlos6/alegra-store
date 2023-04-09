// ignore_for_file: file_names
import 'dart:convert';

import 'package:alegra_store/src/data/env/Env.dart';
import 'package:alegra_store/src/domain/repositories/reporte_repositories.dart';
import 'package:alegra_store/src/domain/requests/reporte_request.dart';
import 'package:http/http.dart' as http;

class ReporteHttp extends ReporteRepositories {
  @override
  Future<List<ReporteRequest>> reporteGeneral() async {
    final url = '${Env.rutaApi}/articles';

    try {
      final res = await http.get(
        Uri.parse(url),
      );

      print('res ${res.body}');
      print(res.statusCode);

      if (res.statusCode == 200) {
        List serviceResponse = json.decode(res.body);
        return serviceResponse.map((e) => ReporteRequest.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('error $e');
      return [];
    }
  }
  @override
  Future<ReporteRequest?> scannerProduct(String itemCode) async {
 
    final url = '${Env.rutaApi}/articles?ItemCode=$itemCode';

    final res = await http.get(Uri.parse(url));
    
    if (res.statusCode != 200) {
      return null;
    }
    List serviceResponse = json.decode(res.body);
    List<ReporteRequest> a =
        serviceResponse.map((e) => ReporteRequest.fromJson(e)).toList();

    return a[0];
  }
}
