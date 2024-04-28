
import 'package:TShop/common/widgets/images/t_rounded_image.dart';
import 'package:TShop/common/widgets/texts/product_title_text.dart';
import 'package:TShop/utils/constants/colors.dart';
import 'package:TShop/utils/constants/image_string.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Image
        TRoundedImage(
          imageUrl: TImages.product4,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkGrey: TColors.light,
          ),
        const SizedBox(width: TSizes.spaceBtwItems),
    
        // Title, Price, Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TBranchTitleWithVerifiedIcon(title: 'Nikc'),
              const Flexible(child: TProductTitleText(title: 'Black Sports Shoes', maxLines: 1)),
              // Attributes 
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Color', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'Blue', style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(text: 'Size', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'UK 01', style: Theme.of(context).textTheme.bodyLarge),
                  ]
                )
              )
            ],
          ),
        )
      ],
    );
  }
}