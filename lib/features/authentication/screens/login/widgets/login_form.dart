import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:goldyu/core/constants/colors.dart';

import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/core/constants/text_strings.dart';
import 'package:goldyu/features/authentication/controllers/login.controller.dart';
import 'package:goldyu/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:goldyu/features/authentication/screens/signup/signup.dart';
import 'package:goldyu/navigation_menu.dart';
import 'package:iconsax/iconsax.dart';

class TLoginForm extends StatelessWidget {
  TLoginForm({
    super.key,
  });

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFieldHeight),

            // Password
            Obx(
              () => TextFormField(
                controller: loginController.passwordController,
                obscureText: loginController.isPasswordHidden.value,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      loginController.isPasswordHidden.value ? Iconsax.eye_slash : Iconsax.eye,
                    ),
                    onPressed: () {
                      loginController.isPasswordHidden.toggle();
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFieldHeight / 2),

            // Remember Me & Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember Me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                // Forgot Password
                TextButton(onPressed: () => Get.to(() => const ForgetPassword()), child: const Text(TTexts.forgotPassword)),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => Get.to(() => NavigationMenu()), child: const Text(TTexts.signIn)),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(onPressed: () => Get.to(() => const SignupScreen()), child: const Text(TTexts.createAccount)),
            ),
          ],
        ),
      ),
    );
  }
}
