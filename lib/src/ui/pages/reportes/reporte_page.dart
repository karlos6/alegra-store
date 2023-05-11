import 'package:alegra_store/src/domain/requests/reporte_filtro_request.dart';
import 'package:alegra_store/src/domain/requests/reporte_request.dart';
import 'package:alegra_store/src/ui/pages/reportes/reporte_controller.dart';
import 'package:alegra_store/src/ui/utilities/mensajesAlerta.dart';
import 'package:alegra_store/src/ui/utilities/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../domain/requests/categoria_producto_request.dart';
import '../../utilities/responsive.dart';

class ReportePage extends StatefulWidget {
  const ReportePage({super.key});

  @override
  State<ReportePage> createState() => _ReportePageState();
}

class _ReportePageState extends State<ReportePage> {
  ScrollController scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  final _actualizadoInputFechaIngreso = TextEditingController();
  final _actualizadoInputFechaSalida = TextEditingController();
  final ReporteController _reporteController = ReporteController();
  final ReporteFiltroRequest _reporteFiltroRequest = ReporteFiltroRequest();
  List<CategoriaProductoRequest> _listaTipoArticulos = [];
  int _currentSortColumn = 0;
  bool _isAscending = true;
  bool isVisible = true;

  Future<List<ReporteRequest>> _listaReportes = Future.value([]);

  @override
  void initState() {
    super.initState();
    _inicializacion();
    _listaReportes = _reporteController.reporteGeneral();
  }

  _inicializacion() async {
    inicializarControlerScroll();
    _listaTipoArticulos = await _reporteController.listarCategoriaReporte();
    setState(() {});
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
        //drawer: Container(),
        appBar: AppBar(
          title: const Text('Reportes'),
        ),
        drawer: const Menu(),
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

  DataTable _tablaDatos(List<ReporteRequest> listaReportes) {
    return DataTable(
      sortColumnIndex: _currentSortColumn,
      sortAscending: _isAscending,
      rows: listaReportes.map((item) {
        return DataRow(cells: [
          DataCell(Text(item.codigo.toString())),
          DataCell(Text(item.nombre)),
          DataCell(Text(item.categoria)),
          DataCell(Text(item.precioCompra.toString())),
          DataCell(Text(item.precioVenta.toString())),
          DataCell(Text(item.cantidad.toString())),
          DataCell(Text(item.peso.toString())),
          DataCell(Text(item.fechaIngreso.toString())),
          DataCell(Text(item.fechaExpiracion.toString())),
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
                      (productB.nombre.compareTo(productA.nombre)));
                } else {
                  _isAscending = true;
                  // sort the product list in Descending, order by nombre
                  listaReportes.sort((productA, productB) =>
                      productA.nombre.compareTo(productB.nombre));
                }
              });
            }),
        DataColumn(
            label:
                const Text('Categoria', style: TextStyle(color: Colors.blue)),
            onSort: (columnIndex, _) {
              setState(() {
                _currentSortColumn = columnIndex;
                if (_isAscending == true) {
                  _isAscending = false;
                  // sort the product list in Ascending, order by tipo
                  listaReportes.sort((productA, productB) =>
                      productB.categoria.compareTo(productA.categoria));
                } else {
                  _isAscending = true;
                  // sort the product list in Descending, order by tipo
                  listaReportes.sort((productA, productB) =>
                      productA.categoria.compareTo(productB.categoria));
                }
              });
            }),
        const DataColumn(label: Text('Precio compra')),
        DataColumn(
            label: const Text(
              'Precio venta',
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
                      productB.precioVenta.compareTo(productA.precioVenta));
                } else {
                  _isAscending = true;
                  // sort the product list in Descending, order by precio
                  listaReportes.sort((productA, productB) =>
                      productA.precioVenta.compareTo(productB.precioVenta));
                }
              });
            }),
        const DataColumn(label: Text('Cantidad')),
        const DataColumn(label: Text('Pesos')),
        const DataColumn(label: Text('Fecha Ingreso')),
        const DataColumn(label: Text('Fecha Expiración')),
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
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _listaTipoArticulo(),
                  SizedBox(height: Adapt.hp(3, context)),
                  const Text("Rango de fechas",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: Adapt.hp(2, context)),
                  _fechaInicioText(),
                  SizedBox(height: Adapt.hp(3, context)),
                  _fechaFinalText(),
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
                    Navigator.pop(context);
                    _listaReportes = _reporteController.reporteGeneral();
                    setState(() {});
                  },
                  child: const Text("Limpiar")),
              TextButton(
                  onPressed: () {
                    _formKey.currentState!.save();
                    if (_reporteFiltroRequest.fechaFinal.isEmpty &&
                        _reporteFiltroRequest.fechaIngreso.isEmpty &&
                        _reporteFiltroRequest.idCategoria == 0) {
                      mensajeAlerta(context, "Alerta Filtro",
                          "Ingrese al menos un filtro para realizar la busqueda");
                    } else {
                      Navigator.pop(context);
                      //  _listaReportes.clear();
                      _listaReportes = _reporteController
                          .reporteFiltrado(_reporteFiltroRequest);
                      setState(() {});
                    }
                  },
                  child: const Text("Filtrar")),
            ],
          );
        });
  }

  Widget _listaTipoArticulo() {
    return DropdownButtonFormField<String>(
      hint: const Text('Seleccione una tipo',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'CaviarDreamsRegular',
          )),
      onSaved: (value) {
        if (value == null) {
          _reporteFiltroRequest.idCategoria = 0;
        } else {
          _reporteFiltroRequest.idCategoria = int.parse(value);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Seleccione una tipo';
        }
        return null;
      },
      isExpanded: true,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        color: Colors.black,
      ),
      items: _listaTipoArticulos.map((CategoriaProductoRequest value) {
        return DropdownMenuItem<String>(
          value: value.id,
          child: Text(value.name,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'CaviarDreamsRegular',
              )),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          newValue;
        });
      },
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(Icons.calendar_month_outlined),
        counterText: "",
        hintText: 'Seleccione un tipo de articulo',
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

  Widget _fechaInicioText() {
    return TextFormField(
      controller: _actualizadoInputFechaIngreso,
      onSaved: (value) => _reporteFiltroRequest.fechaIngreso = value!,
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
            lastDate: (DateTime.now()).add(const Duration(days: 3000)));

        if (newDateTime == null) {
          return;
        }
        String fechaBusqueda = newDateTime.toString().substring(0, 10);
        _actualizadoInputFechaIngreso.text = fechaBusqueda;
      },
      readOnly: true,
      style: const TextStyle(color: Colors.black),
      maxLength: 50,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
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
      onSaved: (value) => _reporteFiltroRequest.fechaFinal = value!,
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
            lastDate: (DateTime.now()).add(const Duration(days: 3000)));

        if (newDateTime == null) {
          return;
        }
        String fechaBusqueda = newDateTime.toString().substring(0, 10);
        _actualizadoInputFechaSalida.text = fechaBusqueda;
      },
      readOnly: true,
      style: const TextStyle(color: Colors.black),
      maxLength: 50,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
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
}
