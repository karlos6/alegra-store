import 'package:alegra_store/src/ui/pages/producto/registrar_producto_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alegra_store/main.dart';

void main() {
  testWidgets('Prueba registro de productos', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: RegistrarArticuloPage()));

    //tester.enterText(find.(TextFormField).first, 'Producto 1');

    // Act (actuar)
    await tester.enterText(
        find.widgetWithText(TextField, 'Codigo del producto'), '12345');

    await tester.enterText(
        find.widgetWithText(TextField, 'Nombre del producto'), 'Producto 1');

    // await tester.enterText(
    //     find.widgetWithText(TextField, 'Tipo de articulo'), );

    await tester.enterText(
        find.widgetWithText(TextField, 'Precio de compra'), '1000');

    await tester.enterText(
        find.widgetWithText(TextField, 'Precio de venta'), '2000');

    // Assert (afirmar)
    //expect(find.text('Mi Producto'), findsOneWidget);

    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
