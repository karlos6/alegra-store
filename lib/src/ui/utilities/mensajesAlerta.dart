// ignore_for_file: file_names

import 'package:alegra_store/src/ui/utilities/responsive.dart';
import 'package:flutter/material.dart';

mensajeAlerta(BuildContext context, String titulo, String mensaje) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            content: Text(mensaje),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Aceptar")),
            ]);
      });
}

creadoExitoso(BuildContext context, String contenido, String ruta) {
  final size = MediaQuery.of(context).size;
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: CircleAvatar(
          radius: size.width * 0.1,
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: size.width * 0.15,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 12.0),
            Text(
              contenido,
              style: const TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    child: Text("Aceptar",
                        style: TextStyle(
                            fontSize: Adapt.px(25), color: Colors.white)),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, ruta);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Future<bool> alertaRetornoBoleano(
    BuildContext context, titulo, contenido) async {
  bool isDelete = false;
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "$titulo",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          content: Text("$contenido",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              )),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  isDelete = false;
                },
                child: const Text("Cancelar")),
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  isDelete = true;
                },
                child: const Text("Aceptar"))
          ],
        );
      });
  return isDelete;
}
