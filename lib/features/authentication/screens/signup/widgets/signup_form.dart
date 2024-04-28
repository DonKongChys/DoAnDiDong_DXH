

import 'package:TShop/common/widgets/login_signup/form_devider.dart';
import 'package:TShop/common/widgets/login_signup/social_button.dart';
import 'package:TShop/features/authentication/screens/signup/verify_email.dart';
import 'package:TShop/features/authentication/screens/signup/widgets/term_condition_checkbox.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/constants/text_string.dart';
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
    return Form(
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
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
          decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct)),
          expands: false,
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
    
        ///Phone number
        TextFormField(
          decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call)),
          expands: false,
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
    
        ///Password
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.password_check),
              labelText: TTexts.password,
              suffixIcon: Icon(Iconsax.eye_slash)),
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
            onPressed: () => Get.to(() => const VerifyEmailScreen()),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 145, 14, 4)), // Thiết lập màu nền
              overlayColor: MaterialStateProperty.all<Color>(
                  Colors.red.shade200), // Thiết lập màu overlay khi nhấn
              side: MaterialStateProperty.all<BorderSide>(
                  const BorderSide(color: Color.fromARGB(255, 137, 13, 4))), // Thiết lập màu viền
            ),
            child: const Text(TTexts.createAccount),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
    
        ///Divider
        TFormDevider(dividerText: TTexts.orSignInwith.capitalize!),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
    
        ///Social buttons
        const TSocialButton()
      ],
    ));
  }
}

