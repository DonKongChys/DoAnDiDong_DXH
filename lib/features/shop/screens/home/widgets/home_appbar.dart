import 'package:TShop/common/widgets/appbar/appbar.dart';
import 'package:TShop/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:TShop/features/personalization/controllers/user_controller.dart';
import 'package:TShop/utils/constants/colors.dart';
import 'package:TShop/utils/constants/text_string.dart';
import 'package:TShop/utils/custom_shimmer/t_shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TAppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TTexts.homeAppBarTitle,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: TColors.grey)),
            Obx(() {
              if (controller.profileLoading.value) {
                // Display a shimmer loader while user profile is being loaded
                return const TShimmerEffect(width: 80, height: 15);
              } else {
                return Text(controller.user.value.fullName,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(color: TColors.white));
              }
            }),
          ],
        ),
        // actions: [Icon(Iconsax.shopping_bag, color: TColors.white)],
        actions: [TCartCounterIcon( iconColor: TColors.white, onPressed: () {  },)],
      ),
    );
  }
}
