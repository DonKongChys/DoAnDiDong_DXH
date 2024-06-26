import 'package:TShop/common/styles/shadows.dart';
import 'package:TShop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:TShop/common/widgets/icons/t_circular_icon.dart';
import 'package:TShop/common/widgets/images/t_rounded_image.dart';
import 'package:TShop/common/widgets/products/cart/add_to_cart_button.dart';
import 'package:TShop/common/widgets/texts/product_price_text.dart';
import 'package:TShop/common/widgets/texts/product_title_text.dart';
import 'package:TShop/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:TShop/features/shop/controllers/product/product_controller.dart';
import 'package:TShop/features/shop/models/product_model.dart';
import 'package:TShop/features/shop/screens/product_details/product_detail.dart';
import 'package:TShop/utils/constants/colors.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.originalPrice, product.salePrice);
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkGrey : TColors.white,
        ),
        child: Column(children: [
          /// Thumbnail, Wishlist button, Discount Tag
          TRoundedContainer(
            height: 180,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Stack(
              children: [
                /// -- Thumbnail Image
                /// // product.thumbnail
                TRoundedImage(
                    imageUrl: product.thumbnail, applyImageRadius: true, isNetworkImage: true),
                //-- Sale Tag
                if(salePercentage!=null)
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        '$salePercentage%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.black),
                      ),
                    ),
                  ),

                /// -- Favourite Icon Button
                const Positioned(
                    right: 0,
                    top: 0,
                    child: TCircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    )),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 4),

          /// -- Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TProductTitleText(title: 'Acer Nitro 5', smallSize: true),
                  TProductTitleText(title: product.title, smallSize: true),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  TBrandTitleWithVerifiedIcon(title: product.brand!.name),
                ],
              ),
            ),
          ),
          const Spacer(),

          /// Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [


              /// Price
              Flexible(
                child: Column(
                  children: [
                    if(product.productType == 'Single' && product.salePrice > 0)
                    // if(product.salePrice > 0)
                      Padding(
                          padding: const EdgeInsets.only(left: TSizes.xs),
                          child: Text(
                            product.originalPrice.toString(),
                            style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                          )
                      ),
                    /// Price, show sale price as main price if sale exist
                    Padding(
                        padding: const EdgeInsets.only(left: TSizes.xs),
                        child: TProductPriceText(price: controller.getProductPrice(product))
                        ),
                  ],
                ),
              ),

              // Add to Cart Button
              ProductCartAddToCartButton(product: product)

              // Container(
              //   decoration: const BoxDecoration(
              //     color: TColors.dark,
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(TSizes.cardRadiusMd),
              //       bottomRight: Radius.circular(TSizes.productImageRadius),
              //     ),
              //   ),
              //   child: const SizedBox(
              //       width: TSizes.iconLg * 1.2,
              //       height: TSizes.iconLg * 1.2,
              //       child:
              //           Center(child: Icon(Iconsax.add, color: TColors.white))),
              // )
            ],
          ),
        ]),
      ),
    );
  }
}
