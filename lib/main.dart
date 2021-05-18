import 'package:flutter/material.dart';
import 'package:hablemos/inh_widget.dart';
import 'package:hablemos/presentation/home.dart';
import 'package:hablemos/routes/routes.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// Funcion Inicial de la Aplicación Hablemos ============================================================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return InhWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Evitar Mensaje de Debug
        initialRoute: '/',
        routes: getApplicationRoutes(),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (context) => HomeScreen(),
          );
        },
      ),
    );
  }
}
