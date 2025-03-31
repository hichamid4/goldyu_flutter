import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/core/constants/text_strings.dart';
import 'package:goldyu/features/authentication/controllers/signup.controller.dart';
import 'package:goldyu/features/authentication/screens/signup/widgets/terms_condiotions_checkbox.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatelessWidget {
  SignupForm({
    super.key,
  });

  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Row(
          //   children: [
          //     Expanded(
          //       child: TextFormField(
          //         expands: false,
          //         decoration: const InputDecoration(
          //             labelText: TTexts.firstName,
          //             prefixIcon: Icon(Iconsax.user)),
          //       ),
          //     ),
          //     const SizedBox(width: TSizes.spaceBtwInputFieldHeight),
          //     Expanded(
          //       child: TextFormField(
          //         expands: false,
          //         decoration: const InputDecoration(
          //             labelText: TTexts.lastName,
          //             prefixIcon: Icon(Iconsax.user)),
          //       ),
          //     ),
          //   ],
          // ),

          // Username
          TextFormField(
            controller: signupController.nameController,
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFieldHeight),

          // Email
          TextFormField(
            controller: signupController.emailController,
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFieldHeight),

          // Password
          Obx(
            () => TextFormField(
              controller: signupController.passwordController,
              obscureText: signupController.isPasswordHidden.value,
              expands: false,
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: Icon(
                    signupController.isPasswordHidden.value ? Iconsax.eye_slash : Iconsax.eye,
                  ),
                  onPressed: () {
                    signupController.isPasswordHidden.toggle();
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Confirm Password
          Obx(
            () => TextFormField(
              controller: signupController.passwordConfirmationController,
              obscureText: signupController.isPasswordHidden2.value,
              expands: false,
              decoration: InputDecoration(
                labelText: TTexts.confirmPassword,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: Icon(
                    signupController.isPasswordHidden2.value ? Iconsax.eye_slash : Iconsax.eye,
                  ),
                  onPressed: () {
                    signupController.isPasswordHidden2.toggle();
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Phone Number
          TextFormField(
            controller: signupController.phoneController,
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFieldHeight),

          // Terms&Conditions Checkbox
          const TermsAndConditionsCheckbox(),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: signupController.signup,
              child: const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
