import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import 'package:goldyu/core/constants/text_strings.dart';
import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/common/styles/spacing_styles.dart';

import 'package:goldyu/common/widgets/General/form_divider.dart';
import 'package:goldyu/common/widgets/General/social_buttn.dart';

import 'package:goldyu/features/authentication/screens/login/widgets/login_form.dart';
import 'package:goldyu/features/authentication/screens/login/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // Logo, Title & Sub-Title
              TLoginHeader(),

              //  Form
              TLoginForm(),

              // Divider
              // TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),

              const SizedBox(height: TSizes.spaceBtwSections),

              // Footer
              // TSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
