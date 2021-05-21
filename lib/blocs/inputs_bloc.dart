import 'dart:async';

import 'package:hablemos/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

///Clase encargada de mantener el email [_emailController], password [_passwordController]
///y nombre [_nameController] de forma transversal a la aplicación y usarla en ciertos campos

class InputsBloc with Validator {
  //Streams
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();

  //Validar stream con el validator
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream<String> get nameStream =>
      _nameController.stream.transform(validarNombre);

  //Validar que espacios sean correctos
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //Funciones para cambiar el valor
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeName => _nameController.sink.add;

  //Obtener ultimo valor encontrado
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get name => _nameController.value;

  //Borrar al final
  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _nameController?.close();
  }
}
