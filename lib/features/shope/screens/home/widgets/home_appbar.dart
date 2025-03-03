import 'package:flutter/material.dart';
import 'package:goldyu/common/widgets/appbar/appbar.dart';
import 'package:goldyu/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/core/constants/text_strings.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTexts.homeAppbarTitle1, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey)),
          Text(TTexts.homeAppbarSubtitleTitle1, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white))
        ],
      ),
      actions: [
        CartCounterIcon(
          iconColor: TColors.white,
          onPressed: () {},
        )
      ],
    );
  }
}
