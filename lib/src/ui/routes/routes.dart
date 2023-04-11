import 'package:alegra_store/src/ui/pages/reportes/reporte_page.dart';
import 'package:alegra_store/src/ui/pages/scanner/scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
      initialRoute: '/scanner',
      routes: {
        '/': (context) => ReportePage(),
        'informe': (context) => ReportePage(),
        '/scanner': (context) => const ScannerPage(),
      },
    );
  }
}
