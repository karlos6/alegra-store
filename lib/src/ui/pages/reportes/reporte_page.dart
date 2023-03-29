import 'dart:math';

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
  final List<Map> _products = [
    {
      "id": 1,
      "nombre": "Arroz",
      "tipo": "Grano",
      "precio": "2000",
      "cantidad": "10",
      "peso": "10 Kg"
    },
    {
      "id": 2,
      "nombre": "Frijol",
      "tipo": "Grano",
      "precio": "7200",
      "cantidad": "60",
      "peso": "7 Kg"
    },
    {
      "id": 3,
      "nombre": "Lenteja",
      "tipo": "Grano",
      "precio": "3800",
      "cantidad": "10",
      "peso": "60 Kg"
    },
    {
      "id": 4,
      "nombre": "Maiz",
      "tipo": "Grano",
      "precio": "3200",
      "cantidad": "45",
      "peso": "20 Kg"
    },
    {
      "id": 5,
      "nombre": "Papa",
      "tipo": "Grano",
      "precio": "2000",
      "cantidad": "10",
      "peso": "10 Kg"
    },
    {
      "id": 6,
      "nombre": "Yuca",
      "tipo": "Grano",
      "precio": "6500",
      "cantidad": "73",
      "peso": "12 Kg"
    },
    {
      "id": 7,
      "nombre": "Cebolla",
      "tipo": "Verdura",
      "precio": "2400",
      "cantidad": "50",
      "peso": "7 Kg"
    },
    {
      "id": 8,
      "nombre": "Ajo",
      "tipo": "Verdura",
      "precio": "1800",
      "cantidad": "40",
      "peso": "3 Kg"
    },
    {
      "id": 9,
      "nombre": "Pimenton",
      "tipo": "Verdura",
      "precio": "5000",
      "cantidad": "25",
      "peso": "11 Kg"
    },
    {
      "id": 10,
      "nombre": "Tomate",
      "tipo": "Verdura",
      "precio": "1000",
      "cantidad": "20",
      "peso": "5 Kg"
    },
    {
      "id": 11,
      "nombre": "Lechuga",
      "tipo": "Verdura",
      "precio": "2500",
      "cantidad": "50",
      "peso": "20 Kg"
    },
    {
      "id": 12,
      "nombre": "Lechuga",
      "tipo": "Verdura",
      "precio": "2500",
      "cantidad": "50",
      "peso": "20 Kg"
    },
    {
      "id": 13,
      "nombre": "Lechuga",
      "tipo": "Verdura",
      "precio": "2500",
      "cantidad": "50",
      "peso": "20 Kg"
    },
    {
      "id": 14,
      "nombre": "Lechuga",
      "tipo": "Verdura",
      "precio": "2500",
      "cantidad": "50",
      "peso": "20 Kg"
    },
    {
      "id": 15,
      "nombre": "Lechuga",
      "tipo": "Verdura",
      "precio": "2500",
      "cantidad": "50",
      "peso": "20 Kg"
    }
  ];

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

  int _currentSortColumn = 0;
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    inicializarControlerScroll();
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
      columns: [
        const DataColumn(label: Text('Código')),
        const DataColumn(label: Text('Nombre')),
        const DataColumn(label: Text('Tipo')),
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
                  _products.sort((productA, productB) =>
                      productB['precio'].compareTo(productA['precio']));
                } else {
                  _isAscending = true;
                  // sort the product list in Descending, order by precio
                  _products.sort((productA, productB) =>
                      productA['precio'].compareTo(productB['precio']));
                }
              });
            }),
        const DataColumn(label: Text('Cantidad')),
        const DataColumn(label: Text('Peso')),
      ],
      rows: _products.map((item) {
        return DataRow(cells: [
          DataCell(Text(item['id'].toString())),
          DataCell(Text(item['nombre'])),
          DataCell(Text(item['tipo'].toString())),
          DataCell(Text(item['precio'].toString())),
          DataCell(Text(item['cantidad'].toString())),
          DataCell(Text(item['peso'].toString())),
        ]);
      }).toList(),
    );
  }
}
