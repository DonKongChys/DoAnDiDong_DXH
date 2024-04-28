import 'package:TShop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:TShop/common/widgets/images/t_circular_image.dart';
import 'package:TShop/common/widgets/texts/product_price_text.dart';
import 'package:TShop/common/widgets/texts/product_title_text.dart';
import 'package:TShop/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:TShop/utils/constants/colors.dart';
import 'package:TShop/utils/constants/enums.dart';
import 'package:TShop/utils/constants/image_string.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      /// Price & Sale Price
      Row(
        children: [
          ///sale tag
          TRoundedContainer(
            radius: TSizes.sm,
            backgroundColor: TColors.secondary.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(
                horizontal: TSizes.sm, vertical: TSizes.xs),
            child: Text(
              '25%',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: TColors.black),
            ),
          ),
          const SizedBox(width: TSizes.spaceBtwItems),

          ///price
          Text('\$250',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough)),
          const SizedBox(width: TSizes.spaceBtwItems),
          const TProductPriceText(
            price: '170',
            isLarge: true,
          ),
        ],
      ),
      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

      /// Title
      const TProductTitleText(
          title: 'Acer Nitro 5 AN515-45-R92M', smallSize: false),
      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

      /// Stock Status
      Row(
        children: [
          const TProductTitleText(title: 'Status'),
          const SizedBox(width: TSizes.spaceBtwItems / 2),
          Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

      /// Brand
       Row(
        children: [
          TCircularImage(
            image: TImages.sportIcon,
            width: 32,
            height: 32,
            overlayColor: darkMode ? TColors.white : TColors.black
          ),
          const SizedBox(width: TSizes.spaceBtwItems / 2),
          const TBrandTitleWithVerifiedIcon(
            title: 'Acer',
            brandTextSize: TextSizes.medium,
          ),
        ],
      ),
    ]);
  }
}
