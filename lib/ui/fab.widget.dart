import 'package:flutter/material.dart';

class Fab extends StatelessWidget {
  final Function onPressed;
  final bool isVisible;
  final IconData icon;
  Fab({@required this.isVisible, this.onPressed, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: FloatingActionButton(
          onPressed: onPressed,
          child: Icon(
            icon,
            color: Colors.white,
          )),
    );
  }
}
