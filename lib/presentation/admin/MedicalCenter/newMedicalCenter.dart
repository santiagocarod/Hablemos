import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hablemos/business/admin/negocioCentrosAtencion.dart';
import 'package:hablemos/model/centro_atencion.dart';
import 'package:hablemos/presentation/admin/MedicalCenter/DptosyCiudades.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class NewMedicalAdmin extends StatefulWidget {
  @override
  _NewMedicalAdminState createState() => _NewMedicalAdminState();
}

class _NewMedicalAdminState extends State<NewMedicalAdmin> {
  TextEditingController nombre;
  TextEditingController telefono;
  String ciudad;
  TextEditingController horario;
  TextEditingController correo;
  TextEditingController direccion;
  bool gratuito;
  List<dynamic> locaciones;
  Map departamento;
  List<dynamic> ciudades = [];

  @override
  void initState() {
    super.initState();
    nombre = TextEditingController();
    telefono = TextEditingController();
    horario = TextEditingController();
    correo = TextEditingController();
    direccion = TextEditingController();
    gratuito = false;
    locaciones = json.decode(locacionesString);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle estiloTitulo = TextStyle(
        color: kAzulLetras,
        fontSize: 19,
        fontWeight: FontWeight.bold,
        fontFamily: "PoppinsRegular");
    return Container(
      color: kAzul3,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: crearAppBar("Nuevo Centro de Atención", null, 0, null,
              context: context),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment(0, -0.5),
                  colors: [kAzul3, kBlanco]),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 110,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Nombre: ", style: estiloTitulo)),
                          TextField(controller: nombre),
                          SizedBox(height: 20),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Telefono (Separado por '-'): ",
                                  style: estiloTitulo)),
                          TextField(controller: telefono),
                          SizedBox(height: 20),
                          Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  Text("Departamento: ", style: estiloTitulo)),
                          DropdownButton(
                              isExpanded: true,
                              value: departamento,
                              items: locaciones.map((dpto) {
                                return DropdownMenuItem<Map>(
                                  child:
                                      Center(child: Text(dpto["departamento"])),
                                  value: dpto,
                                );
                              }).toList(),
                              onChanged: (value) {
                                ciudad = null;
                                setState(() {
                                  departamento = value;
                                  ciudades = value["ciudades"];
                                });
                              },
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontFamily: 'PoppinRegular',
                              )),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Ciudad: ", style: estiloTitulo)),
                          DropdownButton(
                              isExpanded: true,
                              value: ciudad,
                              items: ciudades.map((ciu) {
                                return DropdownMenuItem<String>(
                                  child: Center(child: Text(ciu)),
                                  value: ciu,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  ciudad = value;
                                });
                                print(value["ciudades"]);
                              },
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontFamily: 'PoppinRegular',
                              )),
                          SizedBox(height: 20),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Horario: ", style: estiloTitulo)),
                          TextField(controller: horario),
                          SizedBox(height: 20),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Correo: ", style: estiloTitulo)),
                          TextField(controller: correo),
                          SizedBox(height: 20),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Direccion: ", style: estiloTitulo)),
                          TextField(controller: direccion),
                          SizedBox(height: 20),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Gratuito: ", style: estiloTitulo)),
                          Switch(
                              value: gratuito,
                              onChanged: (bool value) {
                                setState(() {
                                  gratuito = value;
                                });
                              }),
                          SizedBox(height: 20),
                          iconButtonSmall(
                              color: kAzulLetras,
                              function: () {
                                if (nombre.text == "" ||
                                    ciudad == null ||
                                    departamento == null ||
                                    horario.text == "" ||
                                    correo.text == "" ||
                                    direccion.text == "") {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext contex) =>
                                          _buildPopupDialog(context, "Error",
                                              "Por favor ingresa todos los valores"));
                                } else {
                                  CentroAtencion centroAtencion =
                                      CentroAtencion(
                                          ciudad: ciudad,
                                          correo: correo.text,
                                          departamento:
                                              departamento["departamento"],
                                          gratuito: gratuito,
                                          horaAtencion: horario.text,
                                          nombre: nombre.text,
                                          telefono: telefono.text,
                                          ubicacion: direccion.text);
                                  if (agregarCentroAtencion(centroAtencion)) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext contex) =>
                                            _buildPopupDialog(context, "Exito!",
                                                "Centro de Atención Agregado!",
                                                ruta:
                                                    "listCentrosMedicosAdmin"));
                                  }
                                }
                                print(ciudad);
                              },
                              iconData: Icons.save,
                              text: "Guardar"),
                          SizedBox(height: 20)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context, String tittle, String content,
      {String ruta}) {
    return new AlertDialog(
      title: Text(tittle),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(content),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (ruta != null) {
              Navigator.pushNamed(context, ruta);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: kRojoOscuro,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(378.0),
            ),
            shadowColor: Colors.black,
          ),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
