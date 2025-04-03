import 'package:flutter/material.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({
    super.key,
    required this.iconColor,
    required this.onPressed,
  });

  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [IconButton(onPressed: onPressed, icon: Icon(Iconsax.logout, color: iconColor))],
    );
  }
}
