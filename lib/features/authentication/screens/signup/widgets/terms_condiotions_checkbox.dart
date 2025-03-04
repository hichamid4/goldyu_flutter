import 'package:flutter/material.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/core/constants/text_strings.dart';
import 'package:goldyu/core/helpers/helper_functions.dart';

class TermsAndConditionsCheckbox extends StatelessWidget {
  const TermsAndConditionsCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(value: true, onChanged: (value) {}),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Text.rich(TextSpan(
          children: [
            TextSpan(
              text: '${TTexts.iAgreeTo} ',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextSpan(
              text: '${TTexts.privacyPolicy} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? TColors.white : TColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor:
                        dark ? TColors.white : TColors.primaryColor,
                  ),
            ),
            TextSpan(
              text: '${TTexts.and} ',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextSpan(
              text: '${TTexts.termOfUse} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? TColors.white : TColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor:
                        dark ? TColors.white : TColors.primaryColor,
                  ),
            ),
          ],
        ))
      ],
    );
  }
}
