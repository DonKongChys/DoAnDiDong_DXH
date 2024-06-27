import 'package:TShop/common/widgets/appbar/appbar.dart';
import 'package:TShop/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/constants/text_string.dart';
import 'package:TShop/utils/validations/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: const TAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              TTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              TTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems * 2,
            ),

            /// Text field
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validateEmail,
                decoration: const InputDecoration(
                    labelText: TTexts.email,
                    prefixIcon: Icon(Iconsax.direct_right)),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            ///Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.sendPasswordResetEmail(),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(
                            255, 145, 14, 4)), // Thiết lập màu nền
                    overlayColor: WidgetStateProperty.all<Color>(
                        Colors.red.shade200), // Thiết lập màu overlay khi nhấn
                    side: WidgetStateProperty.all<BorderSide>(
                        const BorderSide(
                            color: Color.fromARGB(
                                255, 137, 13, 4))), // Thiết lập màu viền
                  ),
                  child: const Text(TTexts.submit)),
            )
          ],
        ),
      ),
    );
  }
}
