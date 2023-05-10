import 'package:alegra_store/src/data/http/productoHttp.dart';
import 'package:alegra_store/src/domain/requests/reporte_request.dart';
import 'package:alegra_store/src/ui/pages/producto/producto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../domain/requests/producto_request.dart';
import '../../utilities/mensajesAlerta.dart';
import '../../utilities/menu.dart';
import '../../utilities/responsive.dart';

class ListaArticulo extends StatefulWidget {
  const ListaArticulo({super.key});

  @override
  State<ListaArticulo> createState() => _ListaArticuloState();
}

class _ListaArticuloState extends State<ListaArticulo> {
  List<ProductoRequest> listaProductos = [];
  ScrollController scrollController = ScrollController();
  bool isVisible = true;
  ProductoController productoController = ProductoController();

  @override
  void initState() {
    super.initState();
    inicializarControlerScroll();
    inicializarListaProductos();
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

  inicializarListaProductos() async {
    listaProductos = await productoController.listarProductos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Productos'),
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
        listaProductos.isNotEmpty
            ? _listaProductos()
            : const Center(
                child: Text('',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30)),
              ),
        _registrarProductoBoton(),
      ],
    );
  }

  Widget _listaProductos() {
    return SizedBox(
      child: ListView.builder(
        controller: scrollController,
        itemCount: listaProductos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Card(
              elevation: 5,
              child: ListTile(
                title: Text('Nombre: ${listaProductos[index].nombre}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Código: ${listaProductos[index].codigo}'),
                    Text('Tipo: ${listaProductos[index].categoria}'),
                    Text(
                        'Precio de compra: ${listaProductos[index].precioCompra}'),
                    Text(
                        'Precio de venta: ${listaProductos[index].precioVenta}'),
                    Text('Cantidad: ${listaProductos[index].cantidad}'),
                    Text(
                        'Fecha expiración: ${listaProductos[index].fechaExpiracion}'),
                  ],
                ),
                leading: Container(
                  color: Colors.blue[100],
                  width: Adapt.wp(13, context),
                  height: Adapt.hp(12, context),
                  child: Image.asset(
                    'assets/img/productos.png',
                    fit: BoxFit.cover,
                  ),
                ),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  _botonDetallesIncidente(context, index),
                  const SizedBox(
                    width: 5,
                  ),
                  _botonActualizarIncidente(context, index),
                  const SizedBox(
                    width: 5,
                  ),
                  _botonEliminarIncidente(context, index),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _botonDetallesIncidente(BuildContext context, int index) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(3),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'detalles_producto',
                arguments: listaProductos[index]);
          },
          child: const Icon(
            Icons.remove_red_eye_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _botonEliminarIncidente(BuildContext context, int index) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(3),
        child: InkWell(
          onTap: () async {
            bool seleccion = await alertaRetornoBoleano(context,
                "Eliminar producto", "¿Está seguro de eliminar el producto?");
            if (seleccion) {
              // ignore: use_build_context_synchronously
              await productoController.eliminarProducto(
                  context, listaProductos[index]);
              listaProductos.removeAt(index);
              setState(() {});
            }
          },
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Material _botonActualizarIncidente(BuildContext context, int index) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(3),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'actualizar_producto',
                arguments: listaProductos[index]);
          },
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Padding _registrarProductoBoton() {
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
                  child: Text("Registrar producto",
                      style: TextStyle(
                          fontSize: Adapt.px(25), color: Colors.white)),
                  onPressed: () {
                    Navigator.pushNamed(context, 'registrar_articulo');
                  },
                ),
              ),
            )),
      ),
    );
  }
}
