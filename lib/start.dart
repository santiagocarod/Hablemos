import 'package:flutter/material.dart';
import 'package:hablemos/presentation/home.dart';

// Initial screen, shows only the start button (COMENZAR) ======================
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Avoid the debug message
      home: Material(
        child: Stack(
          children: <Widget>[
            // Background Image ================================================
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/start_image.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Start buttom (COMENZAR) =========================================
            Container(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
