import 'package:flutter/material.dart';

class JCTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  JCTextField({@required this.hintText, @required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54),
      ),
      controller: controller,
    );
  }
}
