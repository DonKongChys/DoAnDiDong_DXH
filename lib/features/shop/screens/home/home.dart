import 'package:TShop/common/shimmer/vertical_product_shimmer.dart';
import 'package:TShop/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:TShop/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:TShop/common/widgets/custom_shapes/containers/search_product_page.dart';
import 'package:TShop/common/widgets/layouts/grid_layout.dart';
import 'package:TShop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:TShop/common/widgets/texts/section_heading.dart';
import 'package:TShop/features/shop/controllers/cart_controller.dart';
import 'package:TShop/features/shop/controllers/product/product_controller.dart';
import 'package:TShop/features/shop/screens/all_products/all_products.dart';
import 'package:TShop/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:TShop/features/shop/screens/home/widgets/home_categories.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// App bar
                  const THomeAppBar(),

                  /// Search bar
                  // TSearchContainer(text: "Nhập sản phẩm..."),
                  TSearchContainer1(
                    textController: TextEditingController(),
                    onChanged: (query) => controller.searchProducts(query),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Categories
                  const Padding(
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
                        THomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// --- Promo Slider
                  const TPromoSlider(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  ///Heading
                  TSectionHeading(
                    title: "Popular Products",
                    onPressed: () => Get.to(() => AllProducts(
                          title: 'Sản phẩm phổ biến',
                          futureMethod: controller.fetchAllFeaturedProducts(),
                        )),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// --- Popular Products
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const TVerticalProductShimmer();
                    }

                    final productsToShow = controller.searchedProducts.isEmpty
                        ? controller.featureProducts
                        : controller.searchedProducts;

                    if (productsToShow.isEmpty) {
                      return Center(
                          child: Text('Không có sản phẩm nào!',
                              style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return TGridLayout(
                        itemCount: productsToShow.length,
                        itemBuilder: (_, index) => TProductCardVertical(
                            product: productsToShow[index])
                            );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
