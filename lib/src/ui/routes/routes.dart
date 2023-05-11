import 'package:alegra_store/src/ui/pages/producto/actualizar_producto_page.dart';
import 'package:alegra_store/src/ui/pages/producto/lista_producto_page.dart';
import 'package:alegra_store/src/ui/pages/producto/registrar_producto_page.dart';
import 'package:alegra_store/src/ui/pages/reportes/reporte_page.dart';
import 'package:alegra_store/src/ui/pages/scanner/scanner_page.dart';
import 'package:flutter/material.dart';

import '../pages/producto/detalles_producto_page.dart';

import '../pages/repor_ventas/report_ventas_page.dart';

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alegra App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'lista_articulo',
      routes: {
        '/': (context) => const RegistrarArticuloPage(),
        'informe': (context) => const ReportePage(),
        'scanner': (context) => const ScannerPage(),
        'reportVentas': (context) => const ReporVentas(),
        'registrar_articulo': (context) => const RegistrarArticuloPage(),
        'lista_articulo': (context) => const ListaArticulo(),
        "detalles_producto": (context) => const DetallesProductoPage(),
        "actualizar_producto": (context) => const ActualizarProductoPage(),
      },
    );
  }
}
