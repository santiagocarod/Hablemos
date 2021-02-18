import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Initial screen, shows only the start button (COMENZAR) ======================

class StartFireBase extends StatelessWidget {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Avoid the debug message
      home: Stack(
        children: <Widget>[
          _background(context, size),
          _startButton(context, size),
        ],
      ),
    );
  }
}

Widget _background(BuildContext context, Size size) {
  return SingleChildScrollView(
    child: Image(
      height: size.height,
      width: size.width,
      image: AssetImage("assets/images/start_image.png"),
      fit: BoxFit.cover,
    ),
  );
}

Widget _startButton(BuildContext context, Size size) {
  return SingleChildScrollView(
    // Start buttom (COMENZAR) =========================================
    child: Container(
      width: size.width,
      padding: EdgeInsets.symmetric(
          horizontal: 100, vertical: (size.height / 2) + 50),
      child: Padding(
        padding: EdgeInsets.only(bottom: 347.0),
        child: SizedBox(
          width: 200.0,
          height: 42.0,
          child: ElevatedButton(
            child: Text(
              "COMENZAR",
              style: TextStyle(
                  fontSize: 21.0,
                  color: Colors.black,
                  letterSpacing: 3,
                  fontFamily: 'PoppinSemiBold'),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            onPressed: () {
              /*AuthService authService = new AuthService();
                authService.signUp("santiago@gmail.com", "123456");
                print(
                "User : ${authService.getCurrentUser().then((value) => print(value))}");*/
              Navigator.pushNamed(context, 'start');
            },
          ),
        ),
      ),
    ),
  );
}
