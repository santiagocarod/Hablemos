import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class NewMedicalAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController nombre = TextEditingController();
    TextEditingController telefono = TextEditingController();
    TextEditingController ciudad = TextEditingController();
    TextEditingController departamento = TextEditingController();
    TextEditingController horario = TextEditingController();
    TextEditingController correo = TextEditingController();
    TextEditingController direccion = TextEditingController();

    TextStyle estiloTitulo = TextStyle(
        color: kAzulLetras,
        fontSize: 19,
        fontWeight: FontWeight.bold,
        fontFamily: "PoppinsRegular");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar("Nuevo Centro de Atención", null, 0, null),
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
                height: 150,
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
                          child: Text("Numero: ", style: estiloTitulo)),
                      TextField(controller: telefono),
                      SizedBox(height: 20),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Ciudad: ", style: estiloTitulo)),
                      TextField(controller: ciudad),
                      SizedBox(height: 20),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Departamento: ", style: estiloTitulo)),
                      TextField(controller: departamento),
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
                      TextField(controller: telefono),
                      SizedBox(height: 20),
                      iconButtonSmall(
                          color: kAzulLetras,
                          function: () {},
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
    );
  }
}
