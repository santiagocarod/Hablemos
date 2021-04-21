import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/administrador.dart';

class AdministradorProvider {
  // static Administrador getAdministrador() {
  //   Administrador admin;

  //   String correo = 'admin@gmail.com';
  //   String apellido = 'adminpellido';
  //   String ciudad = 'Bogota';
  //   String permisos = 'Todos los permisos';
  //   String nombre = 'adminombre';

  //   admin = new Administrador(
  //     apellido: apellido,
  //     ciudad: ciudad,
  //     correo: correo,
  //     nombre: nombre,
  //     permisos: permisos,
  //     uid: '12345',
  //   );

  //   addAdmin(admin);
  //   return admin;
  // }

  static addAdmin(Administrador administrador) {
    CollectionReference administradores =
        FirebaseFirestore.instance.collection('administrator');

    administradores.add(administrador.toMap());
  }
}
