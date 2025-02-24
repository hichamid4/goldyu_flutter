import 'package:flutter/material.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/core/device/device_core.dart';
import 'package:goldyu/core/helpers/helper_functions.dart';
import 'package:goldyu/features/authentication/controllers/onboarding.controller.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceCore.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnboardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? TColors.primaryColor : Colors.black,
        ),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
