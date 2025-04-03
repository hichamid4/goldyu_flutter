import 'package:flutter/material.dart';
import 'package:goldyu/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:goldyu/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:goldyu/core/constants/colors.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
    this.height = 400,
  });
  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
      child: SizedBox(
        height: height,
        child: Container(
          color: TColors.primaryColor,
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Positioned(
                top: -100,
                right: -250,
                child: CircularContainer(
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: CircularContainer(
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
