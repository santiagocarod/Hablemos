import 'package:flutter/material.dart';
import 'package:hablemos/inh_widget.dart';
import 'package:hablemos/presentation/home.dart';
import 'package:hablemos/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// Initial Function ============================================================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InhWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Avoid the debug message
        initialRoute: 'home',
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
