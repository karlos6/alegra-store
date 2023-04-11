import '../requests/reporte_filtro_request.dart';
import '../requests/reporte_request.dart';

abstract class ReporteRepositories {
  Future<List<ReporteRequest>> reporteGeneral();
  Future<List<ReporteRequest>> reporteFiltrado(ReporteFiltroRequest filtro);
}
