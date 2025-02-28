import 'package:flutter/material.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/core/constants/image_strings.dart';
import 'package:goldyu/core/constants/sizes.dart';

class TSocialButtons extends StatelessWidget {
  const TSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Google
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: TColors.softGrey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Image(
            width: TSizes.iconMd,
            height: TSizes.iconMd,
            image: AssetImage(TImages.google),
          ),
        ),

        // Space
        const SizedBox(width: TSizes.spaceBtwItems),

        // Facebook
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: TColors.softGrey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Image(
            width: TSizes.iconMd,
            height: TSizes.iconMd,
            image: AssetImage(TImages.facebook),
          ),
        ),
      ],
    );
  }
}
