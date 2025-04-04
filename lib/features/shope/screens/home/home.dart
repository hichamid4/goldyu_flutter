import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:goldyu/common/models/user.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/core/constants/sizes.dart';

import 'package:goldyu/common/widgets/Texts/section_heading.dart';
import 'package:goldyu/common/widgets/custom_shapes/containers/search_conatiner.dart';
import 'package:goldyu/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:goldyu/features/shope/screens/home/widgets/home_appbar.dart';
import 'package:goldyu/features/shope/screens/home/widgets/home_categories.dart';
import 'package:goldyu/features/shope/screens/home/widgets/recent_sales.dart';

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
                  // SearchConatiner(text: 'Search in store'),
                  Center(
                    child: Text(
                      'GOLDY welcomes you , ${data!.name}',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                          ),
                    ),
                  ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SectionHeading(
                  title: 'Your Sales Today:  ${DateTime.now().toString().substring(0, 10)}',
                  showActionButton: false,
                  textColor: TColors.darkerGrey,
                ),
              ],
            ),

            // Recent Sales
            RecentSales(),
          ],
        ),
      ),
    );
  }
}
