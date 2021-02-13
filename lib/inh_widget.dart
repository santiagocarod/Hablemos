import 'package:flutter/material.dart';

class InhWidget extends InheritedWidget {
  static InhWidget _instancia;

  factory InhWidget({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new InhWidget._internal(key: key, child: child);
    }

    return _instancia;
  }

  InhWidget._internal({Key key, Widget child}) : super(key: key, child: child);

  // final signinBloc = SignInBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  // static SignInBloc of(BuildContext context) {
  //   return context.dependOnInheritedWidgetOfExactType<InhWidget>().signinBloc;
  // }
}
