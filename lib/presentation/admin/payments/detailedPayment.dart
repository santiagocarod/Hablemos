import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hablemos/business/admin/negocioPagos.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/pagoadmin.dart';
import 'package:hablemos/ux/atoms.dart';

/// Clse encargada de mostrar el detalle del pago que tiene que hacer un [Prfesional] al administrador
///
/// Se muestra una lista de citas por las cuales tiene que hacer el pago y ademas un costo final total
/// En esta pantalla se puede ademas agrregar un cobro a ser necesario.
/// También se pueden dejar las cuentas en `0` cuando el profesional haya pagado
/// Esta informacion la despliega de un [Pagoadmin] que viene como argumento de la ruta.
class DetailedPaymentAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Pagoadmin pagoAdmin = ModalRoute.of(context).settings.arguments;

    return Stack(
      children: [
        Container(
          child: _background(size),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: crearAppBar("Pagos", null, 0, null, context: context),
            body: Stack(
              children: <Widget>[
                _crearBody(context, size, pagoAdmin),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Fondo de pantalla
  Widget _background(Size size) {
    return Image.asset(
      'assets/images/verdeAdminPagos.png',
      alignment: Alignment.center,
      fit: BoxFit.fill,
      width: size.width,
      height: size.height,
    );
  }

  /// Crea el cuerpo de la información que se quiere mostrar para el [Profesional] especifico
  Widget _crearBody(BuildContext context, Size size, Pagoadmin pagoAdmin) {
    String nombreCompleto =
        "${pagoAdmin.profesional.nombre}  ${pagoAdmin.profesional.apellido}";

    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            _createText(context, size, "Profesional", nombreCompleto),
            SizedBox(height: 30),
            _createText(
                context, size, "Valor Total", pagoAdmin.pago.toString()),
            SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child:
                    _createTable(context, size, pagoAdmin.listCitasProfesional),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: _crearBotones(context, size, pagoAdmin),
            )
          ],
        ),
      ),
    );
  }

  /// Sección general con un [titulo] y una [info]
  Widget _createText(
      BuildContext context, Size size, String titulo, String info) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            titulo,
            style: TextStyle(
              fontFamily: "PoppinsRegular",
              color: kVerdePagos,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            info,
            style: TextStyle(
              fontSize: 21,
            ),
          ),
          SizedBox(height: 15),
          Divider(
            color: Colors.grey[600],
            thickness: 1,
          )
        ],
      ),
    );
  }

  /// Encargado de crear la tabla de citas en donde se da el detalle a pagar por cada una
  Widget _createTable(
      BuildContext context, Size size, List<Map<String, dynamic>> pagos) {
    List<DataRow> rows = [];

    pagos.forEach((element) {
      String nombrePaciente = element["name"];
      String fecha = element["fecha"];

      DataRow data = DataRow(
        cells: [
          DataCell(
            Text(
              "$nombrePaciente",
              style: GoogleFonts.montserrat(
                  fontSize: 17.0, fontWeight: FontWeight.w300),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataCell(
            Text(
              "$fecha",
              style: GoogleFonts.montserrat(
                  fontSize: 17.0, fontWeight: FontWeight.w300),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      );
      rows.add(data);
    });

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: size.width * 0.95),
      child: DataTable(
          headingRowHeight: 41.0,
          dataRowHeight: 80.0,
          sortColumnIndex: 0,
          showBottomBorder: true,
          sortAscending: true,
          headingRowColor: MaterialStateColor.resolveWith((states) {
            return kVerdePagos.withOpacity(0.5);
          }),
          columns: [
            DataColumn(
              label: Text(
                "PACIENTE",
                style:
                    GoogleFonts.montserrat(fontSize: 10.0, letterSpacing: 2.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            DataColumn(
              label: Text(
                "FECHA CITA",
                style:
                    GoogleFonts.montserrat(fontSize: 10.0, letterSpacing: 2.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          rows: rows),
    );
  }

  /// Encargado de los eventos del Administrador
  ///
  /// En caso de que el administrador quiera confirmar el pago del profesional
  /// O añadir un pago adicional
  Widget _crearBotones(BuildContext context, Size size, Pagoadmin pagoadmin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => _buildDialog(
                  context,
                  "Confirmación de pago",
                  "¿Seguro que el profesional ya pagó?",
                  pagoadmin,
                  size),
            );
          },
          child: Row(
            children: <Widget>[
              Icon(Icons.add_circle_outline),
              SizedBox(width: 3),
              Text('Pagó'),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: <Widget>[
              Icon(Icons.remove_circle_outline),
              SizedBox(width: 3),
              Text('No pagó'),
            ],
          ),
        ),
      ],
    );
  }

  /// Dialogo Confirmación de Pago del Profesional
  Widget _buildDialog(BuildContext context, String title, String content,
      Pagoadmin pagoadmin, Size size) {
    return new AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kNegro,
          fontSize: 15.0,
          fontFamily: 'PoppinsRegular',
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kNegro,
          fontSize: 14.0,
          fontFamily: 'PoppinsRegular',
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(37.0),
        side: BorderSide(color: kNegro, width: 2.0),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  aceptarPago(pagoadmin).then((value) {
                    if (value) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => adviceDialogLetter(
                          context,
                          "¡Confirmación!",
                          "¡Pago actualizado correctamente!",
                          true,
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => adviceDialogLetter(
                          context,
                          "Error",
                          "Hubo un error actualizando el pago, inténtalo nuevamente.",
                          true,
                        ),
                      );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(99.0, 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: BorderSide(color: kNegro),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'Si',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.065,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(99.0, 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: BorderSide(color: kNegro),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: kNegro,
                    fontSize: 14.0,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
