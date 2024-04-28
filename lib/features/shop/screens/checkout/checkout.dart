import 'package:TShop/common/widgets/appbar/appbar.dart';
import 'package:TShop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:TShop/common/widgets/products/cart/coupon_widget.dart';
import 'package:TShop/common/widgets/success_screen/success_screen.dart';
import 'package:TShop/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:TShop/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:TShop/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:TShop/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:TShop/navigation_menu.dart';
import 'package:TShop/utils/constants/colors.dart';
import 'package:TShop/utils/constants/image_string.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
       appBar: TAppBar(showBackArrow: true, title: Text('Order Review', style: Theme.of(context).textTheme.headlineSmall)),
       body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Item in  cart
              const TCartItems(showAddRemoveButtons: true),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Coupon TextFeild 
              const TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black: TColors.white,
                child: const Column(
                  children: [
                    // Pricing
                    TBillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    // Divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    // Payment Methods
                    TBillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    // Address
                    TBillingAddressSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                  ],
                ),
              ),
            ],
          ),
        ),
       ),
       bottomNavigationBar: Padding(
         padding: const EdgeInsets.all(TSizes.defaultSpace),
         child: ElevatedButton(
          onPressed: () => Get.to(
            () => SuccessScreen(
                image: TImages.successpayment,
                tittle: 'Payment Success!',
                subtTittle: 'Your item will be shipped soon',
                onPressed: () => Get.offAll(() => const NavigationMenu()),
              ), 
          ),
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

