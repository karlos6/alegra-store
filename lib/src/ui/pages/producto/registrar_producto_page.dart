import 'package:alegra_store/src/domain/requests/categoria_producto_request.dart';
import 'package:alegra_store/src/domain/requests/producto_request.dart';
import 'package:alegra_store/src/ui/pages/producto/producto_controller.dart';
import 'package:flutter/material.dart';
import '../../utilities/responsive.dart';

class RegistrarArticuloPage extends StatefulWidget {
  const RegistrarArticuloPage({super.key});

  @override
  State<RegistrarArticuloPage> createState() => _RegistrarArticuloPageState();
}

class _RegistrarArticuloPageState extends State<RegistrarArticuloPage> {
  List<CategoriaProductoRequest> _listaTipoArticulos = [];
  TextEditingController codigoProductoController = TextEditingController();

  ProductoController productoController = ProductoController();

  final _formKey = GlobalKey<FormState>();
  bool _enEspera = false;
  final _actualizadoInputFechaIngreso = TextEditingController();

  ProductoRequest productoRequest = ProductoRequest();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inicializacion();
  }

  inicializacion() async {
    _listaTipoArticulos = await productoController.listarCategoriaProductos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registrar Producto'),
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
        //_botonFiltrar(),
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
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: Adapt.hp(3, context)),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: _codigoProducto(),
                    ),
                    SizedBox(width: Adapt.wp(2, context)),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () async {
                          codigoProductoController.text =
                              await productoController
                                  .leerCodigoDeBarras(context);
                        },
                        child: const Icon(Icons.qr_code_scanner_outlined),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Adapt.hp(3, context)),
                _nombreProductoText(),
                SizedBox(height: Adapt.hp(3, context)),
                _listaTipoArticulo(),
                SizedBox(height: Adapt.hp(3, context)),
                _precioCompraArticulo(),
                SizedBox(height: Adapt.hp(3, context)),
                _precioVentaProducto(),
                SizedBox(height: Adapt.hp(3, context)),
                _pesoProducto(),
                SizedBox(height: Adapt.hp(3, context)),
                _fechaExpiracionText(),
                SizedBox(height: Adapt.hp(3, context)),
                _cantidadProductoNum(),
                SizedBox(height: Adapt.hp(3, context)),
                _descripcionProducto(),
                SizedBox(height: Adapt.hp(3, context)),
                _botonCrearProducto(),
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
      onSaved: (value) => productoRequest.nombre = value!,
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
      controller: codigoProductoController,
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
      onSaved: (value) => productoRequest.codigo = value!,
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
      onSaved: (value) => productoRequest.precioVenta = int.parse(value!),
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
      onSaved: (value) => productoRequest.precioCompra =
          int.parse(value!), //_reporteFiltroRequest.nombre = value!,
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
      onSaved: (value) => productoRequest.cantidad =
          int.parse(value!), //_reporteFiltroRequest.nombre = value!,
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
      onSaved: (value) => productoRequest.peso = int.parse(value!),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un nombre';
        }
        return null;
      },
    );
  }

  Widget _listaTipoArticulo() {
    return DropdownButtonFormField<String>(
      hint: const Text('Seleccione una tipo',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'CaviarDreamsRegular',
          )),
      onSaved: (value) => productoRequest.idCategory = int.parse(value!),
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
          onTap: () {
            productoRequest.categoria = value.name;
          },
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

  Widget _botonCrearProducto() {
    return SizedBox(
      width: Adapt.wp(70, context),
      height: Adapt.hp(6, context),
      child: ElevatedButton(
        child: _enEspera
            ? Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Text("Espere un momento...")
              ])
            : Text("Registrar producto",
                style: TextStyle(fontSize: Adapt.px(25), color: Colors.white)),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            String fechaActual = DateTime.now().toString().substring(0, 10);
            productoRequest.fechaIngreso = fechaActual;
            productoRequest.categoria = "Alimentos secos";

            print(productoRequest.toJson());

            setState(() {
              _enEspera = true;
            });

            _enEspera = await productoController.registrarProducto(
                context, productoRequest);
          }
          setState(() {});
        },
      ),
    );
  }

  Widget _fechaExpiracionText() {
    return TextFormField(
      controller: _actualizadoInputFechaIngreso,
      onSaved: (value) => productoRequest.fechaExpiracion = value!,
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
        //fechaBusqueda = fechaBusqueda.replaceAll('-', '/');
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
      onSaved: (value) => productoRequest.descripcion =
          value!, //_reporteFiltroRequest.nombre = value!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un nombre';
        }
        return null;
      },
    );
  }
}
