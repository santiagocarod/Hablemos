import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hablemos/presentation/home.dart';
import 'package:hablemos/routes/routes.dart';
import 'package:hablemos/start.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// Initial Function ============================================================
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Avoid the debug message
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      },
      home: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error: ${snapshot.error.toString()}");
            return Text("Algo salio Mal");
          } else if (snapshot.hasData) {
            return Home();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
