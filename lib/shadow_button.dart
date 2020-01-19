import 'package:flutter/material.dart';

class ShadowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;

  const ShadowButton(
      {Key key,
      @required this.onPressed,
      @required this.text,
      @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          //width: 200,
          height: 48,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, size: 24, color: Colors.grey[800]),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(text),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[600],
                    offset: Offset(4.0, 4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
              ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey[300],
                    Colors.grey[400],
                  ],
                  stops: [
                    0.3,
                    1
                  ])),
        ),
      ),
    );
  }
}
