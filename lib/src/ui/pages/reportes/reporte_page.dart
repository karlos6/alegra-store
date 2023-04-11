import 'dart:math';

import 'package:alegra_store/src/data/http/reporteHttp.dart';
import 'package:alegra_store/src/domain/requests/reporte_request.dart';
import 'package:alegra_store/src/ui/pages/reportes/reporte_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../utilities/responsive.dart';

class ReportePage extends StatefulWidget {
  const ReportePage({super.key});

  @override
  State<ReportePage> createState() => _ReportePageState();
}

class _ReportePageState extends State<ReportePage> {
  ScrollController scrollController = ScrollController();
  bool isVisible = true;
  final _actualizadoInputFechaIngreso = TextEditingController();
  final _actualizadoInputFechaSalida = TextEditingController();
  final ReporteController _reporteController = ReporteController();
  List<ReporteRequest> _listaReportes = [];
  int _currentSortColumn = 0;
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _inicializacion();
  }

  _inicializacion() async {
    inicializarControlerScroll();
    _listaReportes = await _reporteController.reporteGeneral();
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
    return SafeArea(
      child: Scaffold(
        drawer: Container(),
        appBar: AppBar(
          title: const Text('Reportes'),
        ),
        //drawer: MenuPorteroWidget(),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        _head(),
        _botonFiltrar(),
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
                _tablaDatos(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _botonFiltrar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: isVisible ? 60.0 : 0.0,
            child: Center(
              child: SizedBox(
                width: Adapt.wp(70, context),
                height: Adapt.hp(6, context),
                child: ElevatedButton(
                  child: Text("Filtro",
                      style: TextStyle(
                          fontSize: Adapt.px(25), color: Colors.white)),
                  onPressed: () {
                    //Navigator.pushNamed(context, 'registrarIncidentes');
                    _filtroMensajeAlerta();
                  },
                ),
              ),
            )),
      ),
    );
  }

  DataTable _tablaDatos() {
    return DataTable(
      sortColumnIndex: _currentSortColumn,
      sortAscending: _isAscending,
      rows: _listaReportes.map((item) {
        return DataRow(cells: [
          DataCell(Text(item.itemCode.toString())),
          DataCell(Text(item.itemName)),
          DataCell(Text(item.typeItem.toString())),
          DataCell(Text(item.price.toString())),
          DataCell(Text(item.quantity.toString())),
          DataCell(Text(item.createDate.toString())),
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
                  _listaReportes.sort((productA, productB) =>
                      (productB.itemName.compareTo(productA.itemName)));
                } else {
                  _isAscending = true;
                  // sort the product list in Descending, order by nombre
                  _listaReportes.sort((productA, productB) =>
                      productA.itemName.compareTo(productB.itemName));
                }
              });
            }),
        DataColumn(
            label: const Text('Tipo', style: TextStyle(color: Colors.blue)),
            onSort: (columnIndex, _) {
              setState(() {
                _currentSortColumn = columnIndex;
                if (_isAscending == true) {
                  _isAscending = false;
                  // sort the product list in Ascending, order by tipo
                  _listaReportes.sort((productA, productB) =>
                      productB.typeItem.compareTo(productA.typeItem));
                } else {
                  _isAscending = true;
                  // sort the product list in Descending, order by tipo
                  _listaReportes.sort((productA, productB) =>
                      productA.typeItem.compareTo(productB.typeItem));
                }
              });
            }),
        DataColumn(
            label: const Text(
              'precio',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            // Sorting function
            onSort: (columnIndex, _) {
              setState(() {
                _currentSortColumn = columnIndex;
                if (_isAscending == true) {
                  _isAscending = false;
                  // sort the product list in Ascending, order by precio
                  _listaReportes.sort((productA, productB) =>
                      productB.price.compareTo(productA.price));
                } else {
                  _isAscending = true;
                  // sort the product list in Descending, order by precio
                  _listaReportes.sort((productA, productB) =>
                      productA.price.compareTo(productB.price));
                }
              });
            }),
        const DataColumn(label: Text('Cantidad')),
        const DataColumn(label: Text('Fecha')),
      ],
    );
  }

  _filtroMensajeAlerta() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: const Text(
              "Filtrar",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _nombreArticuloText(),
                  SizedBox(height: Adapt.wp(3, context)),
                  _tipoArticuloText(),
                  SizedBox(height: Adapt.wp(6, context)),
                  Text("Rango de fechas",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: Adapt.wp(1, context)),
                  _fechaInicioText(),
                  SizedBox(height: Adapt.wp(3, context)),
                  _fechaFinalText(),
                  SizedBox(height: Adapt.wp(3, context)),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar")),
              TextButton(
                  onPressed: () async {
                    _actualizadoInputFechaIngreso.text = "";
                    _actualizadoInputFechaSalida.text = "";
                    setState(() {});
                  },
                  child: const Text("Limpiar")),
              TextButton(onPressed: () async {}, child: const Text("Filtrar")),
            ],
          );
        });
  }

  Widget _fechaInicioText() {
    return TextFormField(
      controller: _actualizadoInputFechaIngreso,
      onSaved: (value) {
        if (value != null) {}
      },
      //validator: (value) => value!.isEmpty ? 'Ingrese la fecha' : null,
      onTap: () async {
        DateTime? newDateTime = await showDatePicker(
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: (DateTime.now()).add(const Duration(days: 0)));

        if (newDateTime == null) {
          return;
        }
        String fechaBusqueda = newDateTime.toString().substring(0, 10);
        fechaBusqueda = fechaBusqueda.replaceAll('-', '/');
        _actualizadoInputFechaIngreso.text = fechaBusqueda;
      },
      readOnly: true,
      style: const TextStyle(color: Colors.black),
      maxLength: 50,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.calendar_month_outlined),
        counterText: "",
        hintText: 'Seleccione la fecha de inicio',
        label: Text(
          'Fecha inicio',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
      onChanged: (value) {},
    );
  }

  Widget _fechaFinalText() {
    return TextFormField(
      controller: _actualizadoInputFechaSalida,
      onSaved: (value) {
        if (value != null) {}
      },
      onTap: () async {
        DateTime? newDateTime = await showDatePicker(
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: (DateTime.now()).add(const Duration(days: 0)));

        if (newDateTime == null) {
          return;
        }
        String fechaBusqueda = newDateTime.toString().substring(0, 10);
        fechaBusqueda = fechaBusqueda.replaceAll('-', '/');
        _actualizadoInputFechaSalida.text = fechaBusqueda;
      },
      readOnly: true,
      style: const TextStyle(color: Colors.black),
      maxLength: 50,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.calendar_month_outlined),
        hintText: 'Seleccione la fecha de fin',
        counterText: "",
        label: Text(
          'Fecha final',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
      onChanged: (value) {},
    );
  }

  Widget _nombreArticuloText() {
    return TextFormField(
      //onSaved: (value) => _visitanteModelRequest.completeName = value!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Este campo es requerido';
        }
        //minimo 4
        if (value.length < 4) {
          return 'El nombre debe tener minimo 4 caracteres';
        }
        //maximo 50
        if (value.length > 60) {
          return 'El nombre debe tener maximo 60 caracteres';
        }
        if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value)) {
          return 'Solo se permiten letras';
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      maxLength: 50,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.shopping_cart_outlined),
        hintText: 'Ingrese el nombre de la visita',
        counterText: "",
        label: Text(
          'Nombre del articulo',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _tipoArticuloText() {
    return TextFormField(
      //onSaved: (value) => _visitanteModelRequest.completeName = value!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Este campo es requerido';
        }
        //minimo 4
        if (value.length < 4) {
          return 'El nombre debe tener minimo 4 caracteres';
        }
        //maximo 50
        if (value.length > 60) {
          return 'El nombre debe tener maximo 60 caracteres';
        }
        if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value)) {
          return 'Solo se permiten letras';
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      maxLength: 50,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.shopping_bag_outlined),
        hintText: 'Ingrese el tipo de articulo',
        counterText: "",
        label: Text(
          'Tipo de articulo',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}
