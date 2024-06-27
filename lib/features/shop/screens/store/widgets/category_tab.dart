import 'package:TShop/common/shimmer/vertical_product_shimmer.dart';
import 'package:TShop/common/widgets/layouts/grid_layout.dart';
import 'package:TShop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:TShop/common/widgets/texts/section_heading.dart';
import 'package:TShop/features/shop/controllers/category_controller.dart';
import 'package:TShop/features/shop/screens/all_products/all_products.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/category_model.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // // Brand
              // CategoryBrands(
              //   category: category,
              // ),
              // const SizedBox(
              //   height: TSizes.spaceBtwItems,
              // ),

              ///-- Products
              FutureBuilder(
                  future:
                      controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {

                    // Helper function handle no record, loader, or error
                    final response =
                        TCloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot,
                            loader: const TVerticalProductShimmer());
                    if (response != null) return response;

                    // Record found
                    final products = snapshot.data!;

                    return Column(children: [
                      TSectionHeading(
                          title: 'Bạn có thể thích',
                          onPressed: () => Get.to(AllProducts(
                              title: category.name,
                              futureMethod: controller.getCategoryProducts(
                                  categoryId: category.id, limit: -1),
                            ),
                          ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      TGridLayout(
                          itemCount: 4,
                          itemBuilder: (_, index) =>
                              TProductCardVertical(product: products[index])),
                    ]);
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
