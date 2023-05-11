class ReporteFiltroRequest {
  int idCategoria = 0;
  String fechaIngreso = '';
  String fechaFinal = '';

  ReporteFiltroRequest();

  ReporteFiltroRequest.fromJson(Map<String, dynamic> json) {
    idCategoria = json['idCategory'] ?? 0;
    fechaIngreso = json['entryDateStart'] ?? '';
    fechaFinal = json['entryDateEnd'] ?? '';
  }

  Map<String, dynamic> toJson() => {
        'idCategory': idCategoria,
        'entryDateStart': fechaIngreso,
        'entryDateEnd ': fechaFinal,
      };
}
