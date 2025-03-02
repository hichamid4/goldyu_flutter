import 'package:flutter/material.dart';

import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/core/device/device_core.dart';
import 'package:goldyu/core/helpers/helper_functions.dart';
import 'package:goldyu/features/authentication/controllers/onboarding.controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: TDeviceCore.getBottomNavigationBarHeight() + 25,
      left: TSizes.defaultSpace,
      child: SmoothPageIndicator(
        count: 3,
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? TColors.light : TColors.dark,
          dotHeight: 8,
        ),
      ),
    );
  }
}
