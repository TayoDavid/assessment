import 'package:flutter/material.dart';

class InlineLoader extends StatelessWidget {
  final double size;
  final Color? strokeColor;

  InlineLoader({super.key, this.size = 20, this.strokeColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        strokeWidth: size == 14 ? 3 : 4,
        valueColor: strokeColor != null
            ? AlwaysStoppedAnimation<Color?>(strokeColor)
            : null,
      ),
    );
  }
}
