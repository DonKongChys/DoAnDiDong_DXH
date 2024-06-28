import 'package:TShop/common/widgets/list_tiles/payment_tile.dart';
import 'package:TShop/common/widgets/texts/section_heading.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_string.dart';
import '../../models/payment_method_model.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Paypal', image: TImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(TSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(
              title: 'Chọn phương thức thanh toán',
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            TPaymentTile(
                paymentMethod:
                    PaymentMethodModel(name: 'Paypal', image: TImages.paypal)),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            TPaymentTile(
                paymentMethod: PaymentMethodModel(
                    name: 'Google Pay', image: TImages.google)),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            TPaymentTile(
                paymentMethod:
                    PaymentMethodModel(name: 'Mono', image: TImages.momo)),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            TPaymentTile(
                paymentMethod:
                    PaymentMethodModel(name: 'Visa', image: TImages.momo)),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
          ],
        ),
      )),
    );
  }
}
