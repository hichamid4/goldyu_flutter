import 'package:flutter/material.dart';
import 'package:goldyu/core/helpers/helper_functions.dart';

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
      width: width,
      height: height,
      padding: EdgeInsets.all(padding ?? 0),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(radius ?? THelperFunctions.screenWidth()),
        color: backgroundColor,
      ),
      // child: child,
    );
  }
}
