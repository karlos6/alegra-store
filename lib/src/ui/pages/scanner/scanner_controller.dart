import 'package:alegra_store/src/data/http/reporteHttp.dart';
import 'package:alegra_store/src/domain/requests/reporte_request.dart';

class ScannerController {
  ReporteHttp reporteHttp = ReporteHttp();

  Future<ReporteRequest?> scannerProduct(String itemCode) {
    return reporteHttp.scannerProduct(itemCode);
  }
}
