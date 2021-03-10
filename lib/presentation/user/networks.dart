import 'package:flutter/material.dart';
import 'package:hablemos/ux/atoms.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Networks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: crearAppBar('', null, 0, null),
      body: Stack(
        children: <Widget>[
          _background(size),
          _appBar(size),
          _list(size),
        ],
      ),
    );
  }
}

Widget _background(Size size) {
  return Image.asset(
    'assets/images/exercisesBack.png',
    alignment: Alignment.center,
    fit: BoxFit.fill,
    width: size.width,
    height: size.height,
  );
}

Widget _appBar(Size size) {
  return Container(
    width: size.width,
    height: size.height * 0.20,
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 20.0),
          child: Icon(
            Icons.phone_iphone_rounded,
            size: 58.0,
          ),
        ),
        Text(
          'Redes',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PoppinsRegular',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _list(Size size) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Center(
      child: Container(
        padding: EdgeInsets.only(top: size.height * 0.25, bottom: 10.0),
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
            _iconText(
                '@HdeSaludMental',
                'https://mobile.twitter.com/HdeSaludMental?s=09',
                'twitter.png'),
            _iconText('Podcast', '', 'spotify.png'),
          ],
        ),
      ),
    ),
  );
}

Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

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
