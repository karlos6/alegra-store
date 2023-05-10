import 'package:alegra_store/src/domain/requests/producto_request.dart';
import 'package:flutter/material.dart';

import '../../utilities/responsive.dart';

class DetallesProductoPage extends StatefulWidget {
  const DetallesProductoPage({super.key});

  @override
  State<DetallesProductoPage> createState() => _DetallesProductoPageState();
}

class _DetallesProductoPageState extends State<DetallesProductoPage> {
  ProductoRequest productoRequest = ProductoRequest();
  @override
  Widget build(BuildContext context) {
    productoRequest =
        ModalRoute.of(context)!.settings.arguments as ProductoRequest;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalles Producto'),
        ),
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
          child: Form(
            child: Column(
              children: [
                SizedBox(height: Adapt.hp(3, context)),
                _codigoProducto(),
                SizedBox(height: Adapt.hp(3, context)),
                _nombreProductoText(),
                SizedBox(height: Adapt.hp(3, context)),
                _categotiaProductoText(),
                SizedBox(height: Adapt.hp(3, context)),
                _precioCompraArticulo(),
                SizedBox(height: Adapt.hp(3, context)),
                _precioVentaProducto(),
                SizedBox(height: Adapt.hp(3, context)),
                _cantidadProductoNum(),
                SizedBox(height: Adapt.hp(3, context)),
                _pesoProducto(),
                SizedBox(height: Adapt.hp(3, context)),
                _fechaExpiracionText(),
                SizedBox(height: Adapt.hp(3, context)),
                _descripcionProducto(),
                SizedBox(height: Adapt.hp(3, context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nombreProductoText() {
    return TextFormField(
      enabled: false,
      initialValue: productoRequest.nombre,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(Icons.point_of_sale_outlined, color: Colors.blue),
        counterText: "",
        hintText: 'ingrese un nombre',
        label: Text(
          'Nombre del producto',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un nombre';
        }
        return null;
      },
    );
  }

  Widget _categotiaProductoText() {
    return TextFormField(
      enabled: false,
      initialValue: productoRequest.categoria,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(Icons.point_of_sale_outlined, color: Colors.blue),
        counterText: "",
        hintText: 'ingrese un nombre',
        label: Text(
          'Tipo de producto',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un nombre';
        }
        return null;
      },
    );
  }

  Widget _codigoProducto() {
    return TextFormField(
      enabled: false,
      initialValue: productoRequest.codigo,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(Icons.qr_code, color: Colors.blue),
        counterText: "",
        hintText: 'ingrese un precio',
        label: Text(
          'Codigo del producto',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un nombre';
        }
        return null;
      },
    );
  }

  Widget _precioVentaProducto() {
    return TextFormField(
      enabled: false,
      initialValue: productoRequest.precioVenta.toString(),
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(Icons.monetization_on, color: Colors.blue),
        counterText: "",
        hintText: 'ingrese un precio',
        label: Text(
          'Precio de venta',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un nombre';
        }
        return null;
      },
    );
  }

  Widget _precioCompraArticulo() {
    return TextFormField(
      enabled: false,
      initialValue: productoRequest.precioCompra.toString(),
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(Icons.monetization_on, color: Colors.blue),
        counterText: "",
        hintText: 'ingrese un precio',
        label: Text(
          'Precio de compra',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un nombre';
        }
        return null;
      },
    );
  }

  Widget _cantidadProductoNum() {
    return TextFormField(
      enabled: false,
      initialValue: productoRequest.cantidad.toString(),
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(Icons.production_quantity_limits, color: Colors.blue),
        counterText: "",
        hintText: 'ingrese una cantidad',
        label: Text(
          'Cantidad',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un nombre';
        }
        return null;
      },
    );
  }

  Widget _pesoProducto() {
    return TextFormField(
      enabled: false,
      initialValue: productoRequest.peso.toString(),
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(Icons.production_quantity_limits, color: Colors.blue),
        counterText: "",
        hintText: 'ingrese el peso',
        label: Text(
          'Peso',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un nombre';
        }
        return null;
      },
    );
  }

  Widget _fechaExpiracionText() {
    return TextFormField(
      enabled: false,
      initialValue: productoRequest.fechaExpiracion,
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
            lastDate: (DateTime.now()).add(const Duration(days: 1000)));

        if (newDateTime == null) {
          return;
        }
        String fechaBusqueda = newDateTime.toString().substring(0, 10);
        //fechaBusqueda = fechaBusqueda.replaceAll('-', '/');
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
        hintText: 'Seleccione la fecha de expiración',
        label: Text(
          'Fecha expiración',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
      onChanged: (value) {},
    );
  }

  Widget _descripcionProducto() {
    return TextFormField(
      enabled: false,
      initialValue: productoRequest.descripcion,
      minLines: 3,
      maxLines: 5,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(Icons.point_of_sale_outlined, color: Colors.blue),
        counterText: "",
        hintText: 'ingrese un descripción',
        label: Text(
          'Descripcion',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un nombre';
        }
        return null;
      },
    );
  }
}
