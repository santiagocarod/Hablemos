import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/services/providers/profesionales_provider.dart';
import 'package:hablemos/ux/atoms.dart';

class HomeProfessionalsManagement extends StatefulWidget {
  @override
  _HomeProfessionalsManagementState createState() =>
      _HomeProfessionalsManagementState();
}

class _HomeProfessionalsManagementState
    extends State<HomeProfessionalsManagement> {
  Profesional profesional = ProfesionalesProvider.getProfesional();
  ScrollController scrollController = ScrollController(
    initialScrollOffset: 0,
    keepScrollOffset: true,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar('Personal de salud', null, 0, null),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/azulDegradado.png',
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height,
          ),
          _body(context, size),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, Size size) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: size.height * 0.15,
          width: double.infinity,
        ),
        Container(
            child: Text(
          'Personal De Salud',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
          ),
        )),
        Container(
          height: size.height * 0.2,
          child: GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.add_circle_outline),
                SizedBox(width: 5),
                Container(
                  child: Text('Agregar'),
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 30,
          color: kRojo,
          child: Center(
              child: Text(
            'Nombre Completo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )),
        ),
        _listProfesionales(context, size),
      ],
    );
  }

  Widget _listProfesionales(BuildContext context, Size size) {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        padding: EdgeInsets.all(2),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'verPerfilProfManage',
                  arguments: profesional);
            },
            child: Column(
              children: [
                Container(
                  height: 30,
                  width: double.infinity,
                  child: Center(
                    child:
                        Text(profesional.nombre + ' ' + profesional.apellido),
                  ),
                ),
                Divider(
                  color: kNegro,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
