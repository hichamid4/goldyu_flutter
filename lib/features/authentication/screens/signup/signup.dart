import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/core/constants/text_strings.dart';

import 'package:goldyu/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:goldyu/common/widgets/General/social_buttn.dart';
import 'package:goldyu/common/widgets/General/form_divider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                TTexts.signUpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Form
              const SignupForm(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Divider
              TFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Social Buttons
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
