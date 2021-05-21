import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///Clase que maneja las redes de la entidad La Papaya
///Donde se hace tambien manejo de abrir urls o su respectiva aplicación
///Solo si se encuentra instalada

class Networks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          child: _background(size),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: crearAppBar('', null, 0, null, context: context),
            body: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      _appBar(size),
                      _list(size),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

///Imagen de atras de la pantalla
Widget _background(Size size) {
  return Image.asset(
    'assets/images/exercisesBack.png',
    alignment: Alignment.center,
    fit: BoxFit.fill,
    width: size.width,
    height: size.height,
  );
}

//Barra superior (AppBar) de la pantalla
Widget _appBar(Size size) {
  return Center(
    child: Container(
      padding: EdgeInsets.only(top: size.height * 0.05, bottom: 10.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Icon(
              Icons.phone_iphone_rounded,
              size: 50.0,
            ),
          ),
          Text(
            'Redes',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PoppinsRegular',
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

///Listado completo de las redes de la papaya
Widget _list(Size size) {
  return Center(
    child: Container(
      padding: EdgeInsets.only(top: size.height * 0.05, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _iconText(
              '@hablemosdesaludmental.co',
              'https://instagram.com/hablemosdesaludmental.co?igshid=8x46trloagti',
              'instagram.png'),
          _iconText('Hablemos de \nSalud Mental',
              'http://www.lapapaya.com.co/SaludMental.html', 'chrome.png'),
          _iconText('@HdeSaludMental',
              'https://mobile.twitter.com/HdeSaludMental?s=09', 'twitter.png'),
          _iconText('Podcast', '', 'spotify.png'),
          _iconText('Medium', 'https://medium.com/', 'medium.png'),
        ],
      ),
    ),
  );
}

///Esta funcion verifica si la aplicacion esta instalada y/o abre la url de la red de la papaya
Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

///Se manejan los diferentes iconos ya que cada red tiene una foto diferente
Widget _iconText(String title, String url, String type) {
  Color color;
  Icon aIcon;
  if (type == "instagram.png") {
    color = const Color(0xFFBE019C);
    aIcon = Icon(
      FontAwesomeIcons.instagram,
      size: 49.0,
      color: color,
    );
  } else if (type == "chrome.png") {
    color = const Color(0xFF3A649C);
    aIcon = Icon(
      FontAwesomeIcons.chrome,
      size: 49.0,
      color: color,
    );
  } else if (type == "twitter.png") {
    color = const Color(0xFF1DA1F2);
    aIcon = Icon(
      FontAwesomeIcons.twitter,
      size: 49.0,
      color: color,
    );
  } else if (type == "spotify.png") {
    color = const Color(0xFF1ED760);
    aIcon = Icon(
      FontAwesomeIcons.spotify,
      size: 49.0,
      color: color,
    );
  } else if (type == "medium.png") {
    color = const Color(0xFFFFC300);
    aIcon = Icon(
      FontAwesomeIcons.medium,
      size: 49.0,
      color: color,
    );
  }

  return GestureDetector(
    onTap: () {
      _launchInBrowser(url);
    },
    child: Column(
      children: <Widget>[
        Container(
          width: 50.08,
          height: 50.9,
          child: aIcon,
        ),
        Text(
          title + '\n',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PoppinsRegular',
            fontSize: 20,
            color: color,
          ),
        ),
      ],
    ),
  );
}
