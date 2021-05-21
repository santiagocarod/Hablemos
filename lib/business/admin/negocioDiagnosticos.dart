import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/diagnostico.dart';

/// Agrega un [diagnostico] a firebase
///
///Llama a la función [revisarListas()] para no enviar listas con elementos vacios
///Retorna `false` en caso de no poder realizar la operacion
bool agregarDiagnostico(Diagnostico diagnostico) {
  bool error = false;
  diagnostico = revisarListas(diagnostico);

  if (!error) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('diagnostics');
    reference.add(diagnostico.toMap()).catchError((value) {
      error = true;
    });
  }
  return !error;
}

/// Actualiza un [diagnostico] a firebase
///
///Llama a la función [revisarListas()] para no enviar listas con elementos vacios
///Retorna `false` en caso de no poder realizar la operacion
bool actualizarDiagnostico(Diagnostico diagnostico) {
  bool error = false;

  diagnostico = revisarListas(diagnostico);

  if (!error) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('diagnostics');
    reference.doc(diagnostico.id).update({
      "definition": diagnostico.definicion,
      "name": diagnostico.nombre,
      "selfhelp": diagnostico.autoayuda,
      "symptoms": diagnostico.sintomas,
      "reference": diagnostico.fuentes
    }).catchError((value) {
      error = true;
    });
  }
  return !error;
}

/// Elimina un [diagnostico] a firebase
void eliminarDiagnostico(Diagnostico diagnostico) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('diagnostics');
  reference.doc(diagnostico.id).delete();
}

///Revisa que las listas del [diagnostico] no envien elementos vacios
Diagnostico revisarListas(Diagnostico diagnostico) {
  diagnostico.fuentes
      .removeWhere((element) => element.toString().replaceAll(" ", "") == "");
  diagnostico.sintomas
      .removeWhere((element) => element.toString().replaceAll(" ", "") == "");

  return diagnostico;
}
