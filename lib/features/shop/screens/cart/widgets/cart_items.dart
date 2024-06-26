import 'package:TShop/common/widgets/products/cart/add_remove_button.dart';
import 'package:TShop/common/widgets/products/cart/cart_item.dart';
import 'package:TShop/common/widgets/texts/product_price_text.dart';
import 'package:TShop/features/shop/controllers/cart_controller.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: cartController.cartItems.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwSections),
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];

          return Column(
            children: [
              TCartItem(cartItem: item),
              if (showAddRemoveButtons)
                const SizedBox(height: TSizes.spaceBtwItems),
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 70),
                        TProductQuantityWidthAddRemoveButton(
                          quantity: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () => cartController.removeOneFromCart(item),
                        ),
                      ],
                    ),
                    //Add Remove Button
                    TProductPriceText(price: (item.price!*item.quantity).toStringAsFixed(1)),
                  ],
                )
            ],
          );
        }),
      ),
    );
  }
}
