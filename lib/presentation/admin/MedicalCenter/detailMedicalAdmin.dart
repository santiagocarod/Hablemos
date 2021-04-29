import 'package:flutter/material.dart';
import 'package:hablemos/model/centro_atencion.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class DetailsMedicalAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CentroAtencion centroAtencion = ModalRoute.of(context).settings.arguments;
    TextEditingController nombre =
        TextEditingController(text: centroAtencion.nombre);
    TextEditingController telefono =
        TextEditingController(text: centroAtencion.telefono);
    TextEditingController ciudad =
        TextEditingController(text: centroAtencion.ciudad);
    TextEditingController departamento =
        TextEditingController(text: centroAtencion.departamento);
    TextEditingController horario =
        TextEditingController(text: centroAtencion.horaAtencion);
    TextEditingController correo =
        TextEditingController(text: centroAtencion.correo);
    TextEditingController direccion =
        TextEditingController(text: centroAtencion.ubicacion);

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
          appBar: crearAppBar(centroAtencion.nombre, null, 0, null),
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
                              child:
                                  Text("Departamento: ", style: estiloTitulo)),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              iconButtonSmall(
                                  color: Colors.red,
                                  function: () {},
                                  iconData: Icons.delete,
                                  text: "Eliminar"),
                              iconButtonSmall(
                                  color: kAzulLetras,
                                  function: () {},
                                  iconData: Icons.save,
                                  text: "Guardar"),
                            ],
                          ),
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
}
