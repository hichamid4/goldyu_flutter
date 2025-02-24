import 'package:flutter/material.dart';
import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/core/device/device_core.dart';
import 'package:goldyu/features/authentication/controllers/onboarding.controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceCore.getAppBarHeight(),
      right: TSizes.defaultSpace - 15,
      child: TextButton(
        onPressed: () => OnboardingController.instance.skipPage(),
        child: const Text('Skip'),
      ),
    );
  }
}
