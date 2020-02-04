import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class ZoomWidget extends StatefulWidget {
  final Widget child;

  const ZoomWidget({this.child});

  @override
  _ZoomWidgetState createState() => _ZoomWidgetState();
}

class _ZoomWidgetState extends State<ZoomWidget> {
  Matrix4 _matrix = Matrix4.identity();

  @override
  Widget build(BuildContext context) {
    return MatrixGestureDetector(
      shouldRotate: false,
      shouldTranslate: false,
      onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm){
        setState(() {
          _matrix = m;
        });

      },
      child: Transform(
        transform: _matrix,
        child: widget.child,
      ),
    );
  }
}