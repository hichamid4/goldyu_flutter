import 'package:flutter/material.dart';
import 'package:goldyu/common/widgets/Texts/section_heading.dart';
import 'package:goldyu/common/widgets/custom_shapes/containers/search_conatiner.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/core/constants/image_strings.dart';
import 'package:goldyu/core/constants/sizes.dart';

import 'package:goldyu/features/shope/screens/home/widgets/home_appbar.dart';
import 'package:goldyu/common/widgets/custom_shapes/containers/primary_header_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  // -- AppBar --
                  const HomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // -- SearchBar --
                  SearchConatiner(text: 'Search in store'),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // -- Categories --
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        // -- Heading --
                        SectionHeading(title: 'Popular Categories', showActionButton: false),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        // -- Categories --
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  Container(
                                    width: 56,
                                    height: 56,
                                    padding: const EdgeInsets.all(TSizes.sm),
                                    decoration: BoxDecoration(
                                      color: TColors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Image(image: AssetImage(TImages.shoeIcon), fit: BoxFit.cover, color: TColors.dark),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
