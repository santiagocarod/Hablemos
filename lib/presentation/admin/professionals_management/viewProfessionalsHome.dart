import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/constants.dart';
import 'package:hablemos/model/profesional.dart';
import 'package:hablemos/util/snapshotConvertes.dart';
import 'package:hablemos/ux/atoms.dart';

class HomeProfessionalsManagement extends StatefulWidget {
  @override
  _HomeProfessionalsManagementState createState() =>
      _HomeProfessionalsManagementState();
}

class _HomeProfessionalsManagementState
    extends State<HomeProfessionalsManagement> {
  //Profesional profesional = ProfesionalesProvider.getProfesional();
  ScrollController scrollController = ScrollController(
    initialScrollOffset: 0,
    keepScrollOffset: true,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    CollectionReference professionalsCollection =
        FirebaseFirestore.instance.collection("professionals");
    return StreamBuilder<QuerySnapshot>(
        stream: professionalsCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('ALGO SALIO MAL');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          Profesional profesional = profesionalMapToList(snapshot)[0];
          return Stack(
            children: [
              Container(
                child: Image.asset(
                  'assets/images/azulDegradado.png',
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fill,
                  width: size.width,
                  height: size.height,
                ),
              ),
              SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  resizeToAvoidBottomInset: false,
                  extendBodyBehindAppBar: true,
                  appBar: crearAppBar('Personal de salud', null, 0, null),
                  body: Stack(
                    children: [
                      _body(context, size, profesional),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _body(BuildContext context, Size size, Profesional profesional) {
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
            onTap: () {
              Navigator.pushNamed(context, 'crearPerfilProfesionalManage');
            },
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
        _listProfesionales(context, size, profesional),
      ],
    );
  }

  Widget _listProfesionales(
      BuildContext context, Size size, Profesional profesional) {
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
