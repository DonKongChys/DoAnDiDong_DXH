import 'package:TShop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:TShop/common/widgets/images/t_circular_image.dart';
import 'package:TShop/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:TShop/features/shop/models/brand_model.dart';
import 'package:TShop/utils/constants/colors.dart';
import 'package:TShop/utils/constants/enums.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({super.key, this.onTap, required this.showBorder, required this.brand});

  final bool showBorder;
  final void Function()? onTap;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,

      /// Container Design
      child: TRoundedContainer(
          showBorder: showBorder,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(TSizes.sm),
        
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// -- Icon
              Flexible(
                  child: TCircularImage(
                isNetworkImage: true,
                image: brand.image,
                backgroundColor: Colors.transparent,
                overlayColor: isDark ? TColors.white : TColors.black,
              )),
              const SizedBox(width: TSizes.spaceBtwItems / 2),

              /// -- Text
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     TBrandTitleWithVerifiedIcon(
                      title: brand.name,
                      brandTextSize: TextSizes.large,
                    ),
                    Text('${brand.productsCount ?? 0} sản phẩm',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall)
                  ],
                ),
              )
            ],
          )),
    );
  }
}
