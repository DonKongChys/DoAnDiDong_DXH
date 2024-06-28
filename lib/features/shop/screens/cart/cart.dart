import 'package:TShop/common/widgets/Loaders/animation_loader.dart';
import 'package:TShop/common/widgets/appbar/appbar.dart';
import 'package:TShop/features/shop/controllers/cart_controller.dart';
import 'package:TShop/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:TShop/features/shop/screens/checkout/checkout.dart';
import 'package:TShop/navigation_menu.dart';
import 'package:TShop/utils/constants/colors.dart';
import 'package:TShop/utils/constants/image_string.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title:
              Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: Obx(() {
        // Nothing found widget
        final emptyWidget = TAnimationLoaderWidget(
          text: 'Bạn chưa thêm sản phẩm nào',
          animation: TImages.cartAnimation,
          showAction: true,
          actionText: 'Mua sắm nào',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        ///
        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TCartItems(),
            ),
          );
        }

        // return Padding(
        //   padding: const EdgeInsets.all(TSizes.defaultSpace),
        //   child: ElevatedButton(
        //       onPressed: () => Get.to(() => const CheckoutScreen()),
        //       style: ButtonStyle(
        //         backgroundColor: MaterialStateProperty.all<Color>(
        //             const Color.fromARGB(255, 145, 14, 4)), // Thiết lập màu nền
        //         overlayColor: MaterialStateProperty.all<Color>(
        //             Colors.red.shade200), // Thiết lập màu overlay khi nhấn
        //         side: MaterialStateProperty.all<BorderSide>(const BorderSide(
        //             color:
        //                 Color.fromARGB(255, 137, 13, 4))), // Thiết lập màu viền
        //       ),
        //       child: const Text('Checkout \$590')),
        // );
      }),

      //Checkout Button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: TColors.primary,
                    side: BorderSide.none, 
  ),
                child: Text('Thanh toán ${controller.formatPrice(controller.totalCartPrice.value)}đ'),
              ),
            ),
    );
  }
}
