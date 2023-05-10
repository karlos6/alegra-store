// ignore_for_file: file_names
import 'dart:convert';

import 'package:alegra_store/src/data/env/Env.dart';
import 'package:alegra_store/src/domain/repositories/reporte_repositories.dart';
import 'package:alegra_store/src/domain/requests/reporte_request.dart';
import 'package:http/http.dart' as http;

import '../../domain/requests/reporte_filtro_request.dart';

class ReporteHttp extends ReporteRepositories {
  @override
  Future<List<ReporteRequest>> reporteGeneral() async {
    final url = '${Env.rutaApi}/getProducts';

    try {
      final res = await http.post(
        Uri.parse(url),
      );

      print("entro a reporte general");
      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        List serviceResponse = json.decode(res.body);
        return serviceResponse.map((e) => ReporteRequest.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
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
    if (itemCode == "8433295060756") {
      return a[0];
    }
    return null;
  }

  @override
  Future<List<ReporteRequest>> reporteFiltrado(
      ReporteFiltroRequest filtro) async {
    final url =
        '${Env.rutaApi}/articles?typeItem=${filtro.tipo}&startDate=${filtro.fechaInicio}&endDate=${filtro.fechaFin}';

    try {
      final res = await http.get(
        Uri.parse(url),
      );

      if (res.statusCode == 200) {
        List serviceResponse = json.decode(res.body);
        return serviceResponse.map((e) => ReporteRequest.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
