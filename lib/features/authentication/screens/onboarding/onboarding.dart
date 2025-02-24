import 'package:flutter/material.dart';

import 'package:goldyu/core/constants/image_strings.dart';
import 'package:goldyu/core/constants/text_strings.dart';
import 'package:goldyu/features/authentication/screens/onboarding/widgets/onboarding.dot.navigation.dart';
import 'package:goldyu/features/authentication/screens/onboarding/widgets/onboarding.next.button.dart';
import 'package:goldyu/features/authentication/screens/onboarding/widgets/onboarding.page.dart';
import 'package:goldyu/features/authentication/screens/onboarding/widgets/onboarding.skip.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Horizontal Scrollable Pages
          PageView(
            children: [
              const OnBoardingPage(
                image: TImages.onboarding1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              const OnBoardingPage(
                image: TImages.onboarding2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              const OnBoardingPage(
                image: TImages.onboarding3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          // Skip Button
          const OnBoardingSkip(),

          // Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          // Circular Button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
