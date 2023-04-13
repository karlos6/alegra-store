// ignore_for_file: use_build_context_synchronously

import 'package:alegra_store/src/domain/requests/reporte_request.dart';
import 'package:alegra_store/src/ui/pages/scanner/scanner_controller.dart';
import 'package:alegra_store/src/ui/utilities/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String barcodeScanRes = "";
  final _reporteController = ScannerController();
  ReporteRequest producto = ReporteRequest();

  void _resetReoirt() {
    producto = ReporteRequest();
  }

  leerCodigo(BuildContext context) async {
    _resetReoirt();
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#3D8BEF', 'Cancelar', false, ScanMode.BARCODE);

    if (barcodeScanRes == "-1") {
      return;
    }
    ReporteRequest? data =
        await _reporteController.scannerProduct(barcodeScanRes);
    if (data != null) {
      producto.itemName = data.itemName;
      producto.itemCode = data.itemCode;
      producto.quantity = data.quantity;

     
    } else {
      displayDialogAndroid(context, barcodeScanRes);
    }

    setState(() {});
  }

  Widget obtnerVista() {
    const fontSize30 = TextStyle(fontSize: 20);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: productData(fontSize30),
      ),
    ));
  }

  List<Widget> productData(TextStyle fontSize30) {
    List<Widget> data;
    if (producto.itemName != "") {
      data = [
        Text('Información producto', style: fontSize30),
        Text('Nombre: ${producto.itemName}', style: fontSize30),
        Text('Código: ${producto.itemCode}', style: fontSize30),
        Text('Existencias: ${producto.quantity}', style: fontSize30),
      ];
    } else {
      data = [];
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: const Text('Scanner Productos')),
      drawer: Menu(),
      body: Center(
        child: obtnerVista(),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0,
          child: const Icon(Icons.filter_center_focus),
          onPressed: () => leerCodigo(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void displayDialogAndroid(BuildContext context, String cod) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: const Text('Código invalido'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "El código '$cod' no se encuentra asociado a ningún producto."),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ok')),
            ],
          );
        });
  }
}
