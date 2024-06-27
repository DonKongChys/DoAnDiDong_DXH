import 'package:TShop/features/shop/controllers/cart_controller.dart';
import 'package:TShop/features/shop/models/product_model.dart';
import 'package:TShop/features/shop/screens/product_details/product_detail.dart';
import 'package:TShop/utils/constants/colors.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductCartAddToCartButton extends StatelessWidget {
  const ProductCartAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return InkWell(
      onTap: () {
        if (product.productType == 'Single') {
          final cartItem = controller.convertToCartItem(product, 1);
          controller.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart =
            controller.getProductQuantityInCart(product.id);
        return Container(
          decoration: BoxDecoration(
            color: productQuantityInCart > 0 ? TColors.primary : TColors.dark,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(TSizes.cardRadiusMd),
              bottomRight: Radius.circular(TSizes.productImageRadius),
            ),
          ),
          child: SizedBox(
              width: TSizes.iconLg * 1.2,
              height: TSizes.iconLg * 1.2,
              child: SizedBox(
                  width: TSizes.iconLg * 1.2,
                  height: TSizes.iconLg * 1.2,
                  child: Center(
                      child: productQuantityInCart > 0
                          ? Text(
                              productQuantityInCart.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(color: TColors.white),
                            )
                          : const Icon(
                              Iconsax.add,
                              color: TColors.white,
                            )))),
        );

        // Container(
        //         decoration: const BoxDecoration(
        //           color: TColors.dark,
        //           borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(TSizes.cardRadiusMd),
        //             bottomRight: Radius.circular(TSizes.productImageRadius),
        //           ),
        //         ),
        //         child: const SizedBox(
        //             width: TSizes.iconLg * 1.2,
        //             height: TSizes.iconLg * 1.2,
        //             child:
        //                 Center(child: Icon(Iconsax.add, color: TColors.white))),
        //       )
      }),
    );
  }
}
