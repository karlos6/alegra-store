import 'package:alegra_store/src/domain/requests/reporte_ventas_request.dart';
import 'package:alegra_store/src/ui/pages/repor_ventas/report_ventas_controller.dart';
import 'package:alegra_store/src/ui/utilities/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../utilities/responsive.dart';

class ReporVentas extends StatefulWidget {
  const ReporVentas({Key? key}) : super(key: key);

  @override
  State<ReporVentas> createState() => _ReporVentasState();
}

class _ReporVentasState extends State<ReporVentas> {
  ScrollController scrollController = ScrollController();
  final _reporteController = ReporteVentaController();
  Future<List<ReporteVentasRequest>> _listaReportes = Future.value([]);
  List<Map<String, String>> listMeses = [
    {"nombre": "Enero", "data": "2023-01-01"},
    {"nombre": "Febrero", "data": "2023-02-01"},
    {"nombre": "Marzo", "data": "2023-03-01"},
    {"nombre": "Abril", "data": "2023-04-01"},
    {"nombre": "Mayo", "data": "2023-05-01"},
    {"nombre": "Junio", "data": "2023-06-01"},
    {"nombre": "Julio", "data": "2023-07-01"},
    {"nombre": "Agosto", "data": "2023-08-01"},
    {"nombre": "Septiembre", "data": "2023-09-01"},
    {"nombre": "Octubre", "data": "2023-10-01"},
    {"nombre": "Noviembre", "data": "2023-11-01"},
    {"nombre": "Diciembre", "data": "2023-12-01"}
  ];
  int _currentSortColumn = 0;
  bool _isAscending = true;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    _inicializacion();
  }

  _inicializacion() async {
    inicializarControlerScroll();
  }

  inicializarControlerScroll() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isVisible) {
          setState(() {
            isVisible = false;
          });
        }
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!isVisible) {
          setState(() {
            isVisible = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: const Text('Reporte Ventas')),
      drawer: const Menu(),
      body: _body(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10), // Ancho del contenedor envolvente
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
                labelText: 'Seleccione un mes', border: InputBorder.none),
            items: listMeses.map((mes) {
              return DropdownMenuItem(
                  value: mes["data"], child: Text(mes["nombre"]!));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _listaReportes = _reporteController.reportVentas(value!);
              });
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _body() {
    return Stack(
      children: [
        _head(),
      ],
    );
  }

  Widget _head() {
    return Center(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        width: Adapt.wp(90, context),
        child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data!.isEmpty) {
                          return const Center(child: Text("No hay datos"));
                        }
                        return _tablaDatos(snapshot.data!);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                    future: _listaReportes)
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataTable _tablaDatos(List<ReporteVentasRequest> listaReportes) {
    return DataTable(
      sortColumnIndex: _currentSortColumn,
      sortAscending: _isAscending,
      rows: listaReportes.map((item) {
        return DataRow(cells: [
          DataCell(Text(item.code.toString())),
          DataCell(Text(item.name)),
          DataCell(Text(item.soldQuantity.toString())),
          DataCell(Text(item.purchasePrice.toString())),
          DataCell(Text(item.salePrice.toString())),
          DataCell(Text(item.profit.toString())),
        ]);
      }).toList(),
      columns: [
        const DataColumn(label: Text('Código')),
        DataColumn(
            label: const Text('Nombre',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            onSort: (columnIndex, _) {
              setState(() {
                _currentSortColumn = columnIndex;
                if (_isAscending == true) {
                  _isAscending = false;
                  // sort the product list in Ascending, order by nombre
                  listaReportes.sort((productA, productB) =>
                      (productB.name.compareTo(productA.name)));
                } else {
                  _isAscending = true;
                  // sort the product list in Descending, order by nombre
                  listaReportes.sort((productA, productB) =>
                      productA.name.compareTo(productB.name));
                }
              });
            }),
        DataColumn(
            label: const Text('Cantidad Vendida',
                style: TextStyle(color: Colors.blue)),
            onSort: (columnIndex, _) {
              setState(() {
                _currentSortColumn = columnIndex;
                if (_isAscending == true) {
                  _isAscending = false;
                  // sort the product list in Ascending, order by tipo
                  listaReportes.sort((productA, productB) =>
                      productB.soldQuantity.compareTo(productA.soldQuantity));
                } else {
                  _isAscending = true;
                  // sort the product list in Descending, order by tipo
                  listaReportes.sort((productA, productB) =>
                      productA.soldQuantity.compareTo(productB.soldQuantity));
                }
              });
            }),
        DataColumn(
            label: const Text(
              'Precio de Compra',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            // Sorting function
            onSort: (columnIndex, _) {
              setState(() {
                _currentSortColumn = columnIndex;
                if (_isAscending == true) {
                  _isAscending = false;
                  // sort the product list in Ascending, order by precio
                  listaReportes.sort((productA, productB) =>
                      productB.purchasePrice.compareTo(productA.purchasePrice));
                } else {
                  _isAscending = true;
                  // sort the product list in Descending, order by precio
                  listaReportes.sort((productA, productB) =>
                      productA.purchasePrice.compareTo(productB.purchasePrice));
                }
              });
            }),
        const DataColumn(label: Text('Precio venta')),
        const DataColumn(label: Text('Ganancia')),
      ],
    );
  }
}
