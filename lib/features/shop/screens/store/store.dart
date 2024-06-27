import 'package:TShop/common/shimmer/brand_shimmer.dart';
import 'package:TShop/common/widgets/appbar/appbar.dart';
import 'package:TShop/common/widgets/appbar/tabbar.dart';
import 'package:TShop/common/widgets/brands/brand_card.dart';
import 'package:TShop/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:TShop/common/widgets/layouts/grid_layout.dart';
import 'package:TShop/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:TShop/common/widgets/texts/section_heading.dart';
import 'package:TShop/features/shop/controllers/brand_controller.dart';
import 'package:TShop/features/shop/controllers/category_controller.dart';
import 'package:TShop/features/shop/screens/brands/all_brands.dart';
import 'package:TShop/features/shop/screens/brands/brand_products.dart';
import 'package:TShop/features/shop/screens/store/widgets/category_tab.dart';
import 'package:TShop/utils/constants/colors.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCategories;
    final brandController = Get.put(BrandController());
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        /// --- AppBar
        appBar: TAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(onPressed: () {}),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 440,
                automaticallyImplyLeading: false,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.black
                    : TColors.white,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// --- Search Bar
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const TSearchContainer(
                          text: 'Search in Store',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// --- Featured Brands
                      TSectionHeading(
                        title: 'Featured Brands',
                        onPressed: () => Get.to(() => const AllBrandsScreen()),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 1.5,
                      ),

                      /// --- Brand GRID
                      Obx(() {
                        if (brandController.isLoading.value) {
                          return const TBrandsShimmer();
                        }

                        if (brandController.featuredBrands.isEmpty) {
                          return Center(
                            child: Text(
                              'Không có dữ liệu',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: Colors.white),
                            ),
                          );
                        }
                        return TGridLayout(
                            itemCount: brandController.featuredBrands.length,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final brand = brandController.featuredBrands[index];
                              return TBrandCard(showBorder: true, brand: brand, onTap:() =>  Get.to(() => BrandProducts(brand: brand)),);
                            });
                      }),
                    ],
                  ),
                ),

                /// --- Tabs
                bottom: TTabBar(
                    tabs: categories
                        .map((category) => Tab(text: category.name))
                        .toList()),
              ),
            ];
          },

          /// --- Body
          body: TabBarView(
              children: categories
                  .map((category) => TCategoryTab(category: category))
                  .toList()),
        ),
      ),
    );
  }
}
