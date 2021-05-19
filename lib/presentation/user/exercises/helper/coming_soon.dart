import 'package:flutter/material.dart';

void showCustomDialog(
  BuildContext context, {
  bool barrierDismissible = true,
  String title = "",
  String subTitle = "",
  String valueTotal = '',
  String imagePath = "assets/adomi-icono.png",
  Widget child,
  List<Widget> actions,
}) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withOpacity(0.5),
    // transitionDuration: Duration(milliseconds: 700),
    context: context,

    pageBuilder: (_, __, ___) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 80,
              child: Image.network(
                "https://media.giphy.com/media/KztT2c4u8mYYUiMKdJ/giphy.gif",
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              subTitle,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 24,
            ),
            child ?? SizedBox(),
          ],
        ),
        actions: actions ?? [],
      );
    },
  );
}
