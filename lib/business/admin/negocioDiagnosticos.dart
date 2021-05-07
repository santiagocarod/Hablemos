import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hablemos/model/diagnostico.dart';

bool agregarDiagnostico(Diagnostico diagnostico) {
  bool error = false;
  diagnostico = revisarListas(diagnostico);

  if (!error) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('diagnostics');
    reference.add(diagnostico.toMap());
  }
  return !error;
}

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
    });
  }
  return !error;
}

void eliminarDiagnostico(Diagnostico diagnostico) {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('diagnostics');
  reference.doc(diagnostico.id).delete();
}

Diagnostico revisarListas(Diagnostico diagnostico) {
  diagnostico.fuentes
      .removeWhere((element) => element.toString().replaceAll(" ", "") == "");
  diagnostico.sintomas
      .removeWhere((element) => element.toString().replaceAll(" ", "") == "");

  return diagnostico;
}
