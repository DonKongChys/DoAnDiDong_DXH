import 'package:TShop/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:TShop/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:TShop/common/widgets/layouts/grid_layout.dart';
import 'package:TShop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:TShop/common/widgets/texts/section_heading.dart';
import 'package:TShop/features/shop/screens/all_products/all_products.dart';
import 'package:TShop/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:TShop/features/shop/screens/home/widgets/home_categories.dart';
import 'package:TShop/utils/constants/image_string.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            const TPrimaryHeaderContainer(
                child: Column(
              children: [
                /// App bar
                THomeAppBar(),

                /// Search bar
                TSearchContainer(text: "Nhập sản phẩm..."),
                SizedBox(height: TSizes.spaceBtwSections),

                /// Categories
                Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        // Heading
                        TSectionHeading(
                          title: 'Danh mục sản phẩm',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),

                        // List_Categories
                        THomeCategories()
                      ],
                    )),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                )
              ],
            )),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// --- Promo Slider
                  const TPromoSlider(banners: [
                    TImages.banner1,
                    TImages.banner2,
                    TImages.banner3
                  ]),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  ///Heading
                  TSectionHeading(
                    title: "Popular Products",
                    onPressed: () => Get.to(() => const AllProducts()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// --- Popular Products
                  TGridLayout(
                      itemCount: 5,
                      itemBuilder: (_, index) => const TProductCardVertical()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
