import 'package:flutter/material.dart';
import 'package:hablemos/business/admin/negocioCentrosAtencion.dart';
import 'package:hablemos/model/centro_atencion.dart';
import 'package:hablemos/ux/atoms.dart';

import '../../../constants.dart';

class DetailsMedicalAdmin extends StatefulWidget {
  CentroAtencion centroAtencion;
  DetailsMedicalAdmin({this.centroAtencion});
  @override
  _DetailsMedicalAdminState createState() =>
      _DetailsMedicalAdminState(this.centroAtencion);
}

class _DetailsMedicalAdminState extends State<DetailsMedicalAdmin> {
  CentroAtencion centroAtencion;
  _DetailsMedicalAdminState(CentroAtencion centroAtencion) {
    this.centroAtencion = centroAtencion;
  }
  TextEditingController nombre;
  TextEditingController telefono;
  TextEditingController ciudad;
  TextEditingController departamento;
  TextEditingController horario;
  TextEditingController correo;
  TextEditingController direccion;
  bool gratuito;

  @override
  void initState() {
    super.initState();
    nombre = TextEditingController(text: widget.centroAtencion.nombre);
    telefono = TextEditingController(text: widget.centroAtencion.telefono);
    ciudad = TextEditingController(text: widget.centroAtencion.ciudad);
    departamento =
        TextEditingController(text: widget.centroAtencion.departamento);
    horario = TextEditingController(text: widget.centroAtencion.horaAtencion);
    correo = TextEditingController(text: widget.centroAtencion.correo);
    direccion = TextEditingController(text: widget.centroAtencion.ubicacion);
    gratuito = widget.centroAtencion.gratuito;
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
          appBar: crearAppBar(widget.centroAtencion.nombre, null, 0, null),
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
                          Switch(
                              value: gratuito,
                              onChanged: (bool value) {
                                setState(() {
                                  gratuito = value;
                                });
                              }),
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
                                  function: () {
                                    CentroAtencion nuevoCentro = CentroAtencion(
                                        id: widget.centroAtencion.id,
                                        ciudad: ciudad.text,
                                        correo: correo.text,
                                        departamento: departamento.text,
                                        gratuito: gratuito,
                                        nombre: nombre.text,
                                        telefono: telefono.text,
                                        ubicacion: direccion.text,
                                        horaAtencion: horario.text);
                                    if (actualizarCentroAtencion(nuevoCentro)) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext contex) =>
                                              _buildPopupDialog(
                                                  context,
                                                  "Exito",
                                                  "El contenido fue actualizado"));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext contex) =>
                                              _buildPopupDialog(
                                                  context,
                                                  "Error",
                                                  "Ocurrio un error\nIntentelo de nuevo mas tarde"));
                                    }
                                  },
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

  Widget _buildPopupDialog(
      BuildContext context, String tittle, String content) {
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
