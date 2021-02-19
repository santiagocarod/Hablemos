import 'package:flutter/material.dart';
import 'package:hablemos/blocs/inputs_bloc.dart';
export 'package:hablemos/blocs/inputs_bloc.dart';

class InhWidget extends InheritedWidget {
  static InhWidget _instancia;

  factory InhWidget({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new InhWidget._internal(key: key, child: child);
    }

    return _instancia;
  }

  final emailPasswordBloc = InputsBloc();

  InhWidget._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static InputsBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InhWidget>()
        .emailPasswordBloc;
  }
}
