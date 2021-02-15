import 'package:flutter/material.dart';

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

// Screen of user that wants to register or login ==============================
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        // Header of screen, image with title ==================================
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(165.0),
          child: AppBar(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(100.0),
                bottomRight: const Radius.circular(100.0),
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/appBar.png"),
                  fit: BoxFit.none,
                ),
              ),
            ),
            elevation: 16,
            backgroundColor: Colors.transparent,
          ),
        ),
        // Body of the screen ==================================================
        body: Stack(
          children: <Widget>[
            // Background image ================================================
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Button of "Necesito Ayuda" ======================================
            Transform.translate(
              offset: Offset(43.0, 231.1),
              child: SizedBox(
                width: 146.0,
                height: 196.0,
                child: FloatingActionButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.perm_phone_msg_rounded,
                        size: 100,
                        color: const Color(0xffe45865),
                      ),
                      Text(
                        "Necesito \nAyuda",
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color(0xff302b2b),
                          height: 1.1111111111111112,
                          fontFamily: 'PoppinsRegular',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              ),
            ),
            // Button of "Qué hay pa hacer" ====================================
            Transform.translate(
              offset: Offset(224.0, 231.12),
              child: SizedBox(
                width: 146.0,
                height: 140.0,
                child: FloatingActionButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.people_alt_rounded,
                        size: 78.67,
                        color: const Color(0xffC08EF2),
                      ),
                      Text(
                        "Qué hay \npa´ hacer",
                        style: TextStyle(
                          fontSize: 17,
                          color: const Color(0xff302b2b),
                          height: 1.1111111111111112,
                          fontFamily: 'PoppinsRegular',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              ),
            ),
            // Button of "Cartas" ==============================================
            Transform.translate(
              offset: Offset(43.0, 452.24),
              child: SizedBox(
                width: 146.0,
                height: 128.0,
                child: FloatingActionButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.send_rounded,
                        size: 63.68,
                        color: const Color(0xffFCD06B),
                      ),
                      Text(
                        "Cartas",
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color(0xff302b2b),
                          height: 1.1111111111111112,
                          fontFamily: 'PoppinsRegular',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              ),
            ),
            // Button of "Quiero un momento" ===================================
            Transform.translate(
              offset: Offset(226.0, 387.24),
              child: SizedBox(
                width: 146.0,
                height: 193.0,
                child: FloatingActionButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.favorite_border_rounded,
                        size: 84.04,
                        color: const Color(0xffA5DF6E),
                      ),
                      Text(
                        "Quiero un \nmomento",
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color(0xff302b2b),
                          height: 1.1111111111111112,
                          fontFamily: 'PoppinsRegular',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              ),
            ),
            // Button of "Redes" ===============================================
            Transform.translate(
              offset: Offset(224.0, 611.12),
              child: SizedBox(
                width: 146.0,
                height: 128.0,
                child: FloatingActionButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.tablet_mac_rounded,
                        size: 75.0,
                        color: const Color(0xffFFD4C4),
                      ),
                      Text(
                        "Redes",
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color(0xff302b2b),
                          height: 1.1111111111111112,
                          fontFamily: 'PoppinsRegular',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              ),
            ),
            // Button of "Información" =========================================
            Transform.translate(
              offset: Offset(43.0, 611.12),
              child: SizedBox(
                width: 146.0,
                height: 128.0,
                child: FloatingActionButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.message_rounded,
                        size: 85.67,
                        color: const Color(0xff46D4E1),
                      ),
                      Text(
                        "Información",
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color(0xff302b2b),
                          height: 1.1111111111111112,
                          fontFamily: 'PoppinsRegular',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  backgroundColor: Colors.white,
                  onPressed: () {
                    _settingBottomSheet(context);
                  },
                ),
              ),
            ),
            // Button of "Iniciar Sesión" ======================================
            Transform.translate(
              offset: Offset(0.0, 770.0),
              child: SizedBox(
                width: 206.0,
                height: 77.0,
                child: FloatingActionButton(
                  child: Text(
                    "Iniciar Sesión",
                    style: TextStyle(
                      fontSize: 22,
                      color: const Color(0xffE45865),
                      height: 1.1111111111111112,
                      fontFamily: 'PoppinsRegular',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: const Color(0xffFCD06B),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              ),
            ),
            // Button of "Registrarme" =========================================
            Transform.translate(
              offset: Offset(206.0, 770.0),
              child: SizedBox(
                width: 206.0,
                height: 77.0,
                child: FloatingActionButton(
                  child: Text(
                    "Registrarme",
                    style: TextStyle(
                      fontSize: 22,
                      color: const Color(0xff202830),
                      height: 1.1111111111111112,
                      fontFamily: 'PoppinsRegular',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: const Color(0xffFCD06B),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Function of the bottom sheet of the "Información" button ====================
void _settingBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: 141,
          child: _buildItems(context),
        );
      });
}

// Buttons of bottom sheet =====================================================
Widget _buildItems(BuildContext context) {
  return Container(
    // Bottom sheet properties =================================================
    width: 412.0,
    height: 141.44,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(70.0),
        topRight: const Radius.circular(70.0),
      ),
      color: const Color(0xff8EE8D8),
    ),
    // Buttons =================================================================
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // Button of "Foro" ====================================================
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 140.75,
              height: 80.67,
              child: FloatingActionButton(
                child: Icon(
                  Icons.comment_bank_outlined,
                  size: 84.71,
                  color: const Color(0xff205072),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(81.0),
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              ),
            ),
            Text(
              "Foro",
              style: TextStyle(
                fontSize: 18,
                color: const Color(0xff302b2b),
                height: 1.1111111111111112,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        // Button of "Salud Mental" ============================================
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 140.75,
              height: 80.67,
              child: FloatingActionButton(
                child: Icon(
                  Icons.monitor,
                  size: 84.71,
                  color: const Color(0xff205072),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(81.0),
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              ),
            ),
            Text(
              "Salud Mental",
              style: TextStyle(
                fontSize: 18,
                color: const Color(0xff302b2b),
                height: 1.1111111111111112,
                fontFamily: 'PoppinsRegular',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    ),
  );
}
