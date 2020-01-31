import 'package:flutter/material.dart';

class Fab extends StatelessWidget {
  final Function onPressed;
  final bool isVisible;
  Fab({@required this.isVisible, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: FloatingActionButton(
          onPressed: onPressed,
          child: Icon(
            Icons.mic,
            color: Colors.white,
          )),
    );
  }
}
