import 'dart:async';

/// Clase que nos ayuda a validar que el email y el password ingresados si sean validos
/// De esta forma evitamos que se suban cosas no permitidas a firebase
class Validator {
  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp regExp = new RegExp(pattern);

      if (regExp.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError('Correo debe ser: tucorreo@correo.com');
      }
    },
  );

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 6) {
        sink.add(password);
      } else {
        sink.addError('Contraseña minimo de 6 caracteres');
      }
    },
  );

  final validarNombre = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name.length == 0) {
        sink.add(name);
      } else {
        sink.addError('Este campo es necesario');
      }
    },
  );
}
