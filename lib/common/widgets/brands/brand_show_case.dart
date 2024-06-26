import 'package:TShop/common/widgets/brands/brand_card.dart';
import 'package:TShop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:TShop/features/shop/models/brand_model.dart';
import 'package:TShop/features/shop/screens/brands/brand_products.dart';
import 'package:TShop/utils/constants/colors.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/custom_shimmer/t_shimmer_effect.dart';


class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({super.key, required this.images,required this.brand});

  final List<String> images;
  final BrandModel brand;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand,)),
      child: TRoundedContainer(
        showBorder: true,
        borderColor: TColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Column(
          children: [
            ///Brand with Products Count
            TBrandCard(showBorder: false, brand: brand),
            const SizedBox(  
              height: TSizes.spaceBtwItems,
            ),
      
            /// Brand Top 3 Product Images
            Row(
              children: images
                  .map((image) => brandTopProductImageWidget(image, context))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
        child: TRoundedContainer(
      height: 100,
      backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkGrey : TColors.light,
      margin: const EdgeInsets.only(right: TSizes.sm),
      padding: const EdgeInsets.all(TSizes.md),
      child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) => const TShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
