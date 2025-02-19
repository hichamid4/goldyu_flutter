import 'package:flutter/material.dart';
import 'package:goldyu/core/constants/image_strings.dart';
import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/core/constants/text_strings.dart';
import 'package:goldyu/core/helpers/helper_functions.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              Column(
                children: [
                  // const SizedBox(height: 80),
                  Lottie.asset(
                    TImages.onboarding2,
                    width: THelperFunctions.screenWidth() * 0.8,
                    height: THelperFunctions.screenHeight() * 0.4,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    TTexts.onBoardingTitle1,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                    TTexts.onBoardingSubTitle1,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
