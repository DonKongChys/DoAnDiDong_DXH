import 'package:TShop/common/widgets/texts/section_heading.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'widget/bottom_add_to_cart_widget.dart';
import 'widget/product_attributes.dart';
import 'widget/product_detail_image_slider.dart';
import 'widget/product_meta_data.dart';
import 'widget/rating_share _widget.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///1.product image slider
            TProductImageSlider(),

            ///2.product details
            Padding(
              padding: const EdgeInsets.only(
                  left: TSizes.defaultSpace,
                  right: TSizes.defaultSpace,
                  top: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  /// - Rating & Share Button
                  const TRatingAndShare(),

                  /// - Price, Title, Stock, & Brand
                  const TProductMetaData(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  /// -- Attributes
                  const TProductAttributes(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// -- Checkout Button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('Checkout'))),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// - Description
                  const TSectionHeading(
                      title: 'Description', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const ReadMoreText(
                      'The Nike Air Max 270 React ENG combines a full-length React foam midsole with a 270 Max Air unit for unrivaled comfort and a striking visual experience. The shoe’s upper features lightweight, no-sew materials that create a modern aesthetic that looks as good as it feels.',
                      trimLines: 3,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                      lessStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),

                  /// - Reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TSectionHeading(
                          title: 'Reviews(199)', onPressed: (){}, showActionButton: false,),
                      IconButton(icon: const Icon(Iconsax.arrow_right_3,size: 18,), onPressed: (){}, )
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
