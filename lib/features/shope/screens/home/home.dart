import 'package:flutter/material.dart';
import 'package:goldyu/common/models/user.dart';
import 'package:goldyu/core/constants/sizes.dart';

import 'package:goldyu/common/widgets/Texts/section_heading.dart';
import 'package:goldyu/common/widgets/custom_shapes/containers/search_conatiner.dart';
import 'package:goldyu/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:goldyu/features/shope/screens/home/widgets/gold_price_card.dart';
import 'package:goldyu/features/shope/screens/home/widgets/home_appbar.dart';
import 'package:goldyu/features/shope/screens/home/widgets/home_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.data});

  final User? data;

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
                  HomeAppBar(user: data!),
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
                        SectionHeading(title: 'Your Categories', showActionButton: false, textColor: Colors.white),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        // -- Categories --
                        HomeCategories(),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // New Sections Below Categories
            const SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
