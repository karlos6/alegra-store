import '../requests/reporte_request.dart';

abstract class ReporteRepositories {
  Future<List<ReporteRequest>> reporteGeneral();

Future<ReporteRequest?> scannerProduct(String itemCode);
}
