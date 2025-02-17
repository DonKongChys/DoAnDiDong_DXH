import 'package:TShop/features/shop/controllers/cart_controller.dart';
import 'package:TShop/features/shop/screens/cart/cart.dart';
import 'package:TShop/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    this.iconColor,
    required this.onPressed,
  });

  final Color? iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(CartController());
    return Stack(
      children: [
        IconButton(
            onPressed: () => Get.to(() => const CartScreen()),
            // onPressed: () {},
            icon: Icon(Iconsax.shopping_bag, color: iconColor)),
        Positioned(
          right: 0,
          child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: TColors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Obx(
                  () => Text(controller.noOfCartItems.value.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: TColors.white, fontSizeFactor: 0.8)),
                ),
              )),
        )
      ],
    );
  }
}
