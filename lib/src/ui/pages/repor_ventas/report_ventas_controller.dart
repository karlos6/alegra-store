import 'package:alegra_store/src/data/http/reporteHttp.dart';
import 'package:alegra_store/src/domain/requests/reporte_ventas_request.dart';

class ReporteVentaController {
  ReporteHttp reporteHttp = ReporteHttp();

  Future<List<ReporteVentasRequest>> reportVentas(String mes) async {
    return await reporteHttp.reportVentas(mes);
  }
}
