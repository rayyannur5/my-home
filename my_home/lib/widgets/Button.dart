import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double height;
  final double width;
  final double elevation;
  final double borderRadius;
  final Function onTap;
  final Color color;
  final Widget child;
  Button(
      {this.height = 40,
      this.width = 70,
      this.elevation = 0,
      this.borderRadius = 20,
      this.color = Colors.black,
      required this.onTap,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Material(
        elevation: elevation,
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: () {
            onTap();
          },
          child: child,
        ),
      ),
    );
  }
}
