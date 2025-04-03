import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/widgets/Texts/section_heading.dart';
import 'package:goldyu/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:goldyu/core/constants/colors.dart';
import 'package:goldyu/core/constants/sizes.dart';
import 'package:goldyu/features/shope/controllers/sale.controller.dart';
import 'package:goldyu/features/shope/screens/home/widgets/home_appbar.dart';
import 'package:goldyu/features/shope/screens/home/widgets/home_categories.dart';
import 'package:goldyu/features/shope/screens/home/widgets/sale_card.dart';
import 'package:goldyu/features/shope/screens/sales/widgets/sales_filter.dart';
import 'package:goldyu/features/shope/screens/sales/widgets/sales_list.dart';

class SalesScreen extends StatelessWidget {
  SalesScreen({super.key});

  final SaleController saleController = Get.put(SaleController());

  @override
  Widget build(BuildContext context) {
    saleController.fetchSales();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  // -- AppBar --
                  HomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // -- SearchBar --
                  // SearchConatiner(text: 'Search in store'),
                  SalesFilterWidget(),
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

            // Sales
            SalesList(),
          ],
        ),
      ),
    );
  }
}
