import 'package:alegra_store/src/data/http/reporteHttp.dart';
import 'package:alegra_store/src/domain/requests/reporte_request.dart';

import '../../../domain/requests/reporte_filtro_request.dart';

class ReporteController {
  ReporteHttp reporteHttp = ReporteHttp();

  Future<List<ReporteRequest>> reporteGeneral() async {
    return await reporteHttp.reporteGeneral();
  }

  Future<List<ReporteRequest>> reporteFiltrado(
      ReporteFiltroRequest filtro) async {
    return await reporteHttp.reporteFiltrado(filtro);
  }
}
