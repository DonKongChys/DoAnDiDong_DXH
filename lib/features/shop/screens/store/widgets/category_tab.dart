import 'package:TShop/common/widgets/brands/brand_show_case.dart';
import 'package:TShop/common/widgets/layouts/grid_layout.dart';
import 'package:TShop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:TShop/common/widgets/texts/section_heading.dart';
import 'package:TShop/features/shop/models/product_model.dart';
import 'package:TShop/utils/constants/image_string.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import '../../../models/category_model.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Brands
              const TBrandShowcase(images: [
                TImages.product1,
                TImages.product2,
                TImages.product3
              ]),
              const TBrandShowcase(images: [
                TImages.product1,
                TImages.product2,
                TImages.product3
              ]),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              ///-- Products
              TSectionHeading(title: 'You might like', onPressed: () {}),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              TGridLayout(
                  itemCount: 4,
                  itemBuilder: (_, index) => TProductCardVertical(product: ProductModel.empty())),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
