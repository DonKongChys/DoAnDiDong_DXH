import 'package:TShop/common/widgets/appbar/appbar.dart';
import 'package:TShop/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:TShop/features/shop/screens/checkout/checkout.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title:
              Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),

        // Items in Cart
        child: TCartItems(),
      ),

      //Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 145, 14, 4)), // Thiết lập màu nền
              overlayColor: MaterialStateProperty.all<Color>(
                  Colors.red.shade200), // Thiết lập màu overlay khi nhấn
              side: MaterialStateProperty.all<BorderSide>(
                  const BorderSide(color: Color.fromARGB(255, 137, 13, 4))), // Thiết lập màu viền
            ),
            child: const Text('Checkout \$590')),
      ),
    );
  }
}
