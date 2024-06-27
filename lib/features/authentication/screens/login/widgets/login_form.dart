import 'package:TShop/features/authentication/controllers/login/login_controller.dart';
import 'package:TShop/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:TShop/features/authentication/screens/signup/signup.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/constants/text_string.dart';
import 'package:TShop/utils/validations/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(children: [
          /// Email
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: TTexts.email,
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          ///Password
          Obx(
            () => TextFormField(
              validator: (value) => TValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: Icon(controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye))),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields / 2,
          ),

          ///Remember me and forget password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///Remember me
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) => controller.rememberMe.value =
                          !controller.rememberMe.value,
                    ),
                  ),
                  const Text(TTexts.rememberMe)
                ],
              ),

              ///Forget password
              TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(TTexts.forgetPassword))
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwSections),

          ///Sign in button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.emailAndPasswordSignIn(),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(
                            255, 156, 12, 2)), // Thiết lập màu nền
                    overlayColor: WidgetStateProperty.all<Color>(
                        Colors.red.shade200), // Thiết lập màu overlay khi nhấn
                    side: WidgetStateProperty.all<BorderSide>(
                        const BorderSide(
                            color: Color.fromARGB(
                                255, 149, 13, 3))), // Thiết lập màu viền
                  ),
                  child: const Text(TTexts.signIn))),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          /// Sign up button
          SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                      color: Color.fromARGB(
                          255, 149, 16, 7)), // Thiết lập màu của đường viền
                ),
                child: const Text(TTexts.createAccount),
              )),

          // const SizedBox(
          //   height: TSizes.spaceBtwItems,
          // )
        ]),
      ),
    );
  }
}
