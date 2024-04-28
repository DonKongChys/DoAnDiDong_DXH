import 'package:TShop/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:TShop/features/authentication/screens/signup/signup.dart';
import 'package:TShop/navigation_menu.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/constants/text_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(children: [
          ///Email
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: TTexts.email,
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          ///Password
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash)),
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
                  Checkbox(value: true, onChanged: (value) {}, activeColor: const Color.fromARGB(255, 163, 14, 4), checkColor: Colors.white,),
                  const Text(TTexts.rememberMe)
                ],
              ),

              ///Forget password
              TextButton(
                  onPressed: () => Get.to(() => const FogetPassword()),
                  child: const Text(TTexts.forgetPassword))
            ],
          ),

          ///Sign in button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const NavigationMenu()),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 156, 12, 2)), // Thiết lập màu nền
                    overlayColor: MaterialStateProperty.all<Color>(
                        Colors.red.shade200), // Thiết lập màu overlay khi nhấn
                    side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(
                            color: Color.fromARGB(255, 149, 13, 3))), // Thiết lập màu viền
                  ),
                  child: const Text(TTexts.signIn))),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          ///Sign up button
          SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () => Get.to(() => const SignupScreen()),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 149, 16, 7)), // Thiết lập màu của đường viền
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
