import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.width,
    this.height,
    this.radius,
    this.padding,
    this.child,
    this.backgroundColor,
  });

  final double? width;
  final double? height;
  final double? radius;
  final double? padding;
  final Widget? child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 400,
      height: height ?? 400,
      padding: EdgeInsets.all(padding ?? 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 400),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
