import 'package:TShop/common/widgets/login_signup/form_devider.dart';
import 'package:TShop/common/widgets/login_signup/social_button.dart';
import 'package:TShop/features/authentication/controllers/signup/signup_controller.dart';
import 'package:TShop/features/authentication/screens/signup/widgets/term_condition_checkbox.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/constants/text_string.dart';
import 'package:TShop/utils/validations/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        TValidator.validateEmptyText("First name", value),
                    decoration: const InputDecoration(
                        labelText: TTexts.firstName,
                        prefixIcon: Icon(Iconsax.user)),
                    expands: false,
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwInputFields,
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        TValidator.validateEmptyText("Last name", value),
                    decoration: const InputDecoration(
                        labelText: TTexts.lastName,
                        prefixIcon: Icon(Iconsax.user)),
                    expands: false,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            ///Username
            TextFormField(
              controller: controller.username,
              validator: (value) =>
                  TValidator.validateEmptyText("User name", value),
              decoration: const InputDecoration(
                  labelText: TTexts.username,
                  prefixIcon: Icon(Iconsax.user_edit)),
              expands: false,
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            // ///Email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                  labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
              expands: false,
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            /// Phone number
            TextFormField(
              controller: controller.phoneNumber,
              validator: (value) => TValidator.validatePhoneNumber(value),
              decoration: const InputDecoration(
                  labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
              expands: false,
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            /// Password
            Obx(
              () => TextFormField(
                validator: (value) => TValidator.validatePassword(value),
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      icon: Icon(controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye),
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                    )),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            ///Term and condition chechbox
            TermConditionCheckBox(dark: dark),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            ///Signup button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.signup(),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      const Color.fromARGB(
                          255, 145, 14, 4)), // Thiết lập màu nền
                  overlayColor: WidgetStateProperty.all<Color>(
                      Colors.red.shade200), // Thiết lập màu overlay khi nhấn
                  side: WidgetStateProperty.all<BorderSide>(const BorderSide(
                      color: Color.fromARGB(
                          255, 137, 13, 4))), // Thiết lập màu viền
                ),
                child: const Text(TTexts.createAccount),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            ///Divider
            TFormDivider(dividerText: TTexts.orSignInwith.capitalize!),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            ///Social buttons
            const TSocialButtons()
          ],
        ));
  }
}
