// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TShop/data/repositories/authentication/authentication_repository.dart';
import 'package:TShop/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:TShop/utils/constants/image_string.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/constants/text_string.dart';
import 'package:TShop/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({
    Key? key,
    this.email,
  }) : super(key: key);
  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => AuthenticationRepository.instance.logout(),
                icon: const Icon(CupertinoIcons.clear))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                ///Image
                Image(
                  image: const AssetImage(TImages.deliveriedEmailIllustration),
                  width: THelperFunctions.screenWidth() * 0.6,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                ///Tittle and subtittle
                Text(
                  TTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                Text(
                  email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                Text(
                  TTexts.confirmEmailSubTittle,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                ///Buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.checkEmailVerificationStatus(),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(
                              255, 145, 14, 4)), // Thiết lập màu nền
                      overlayColor: WidgetStateProperty.all<Color>(Colors
                          .red.shade200), // Thiết lập màu overlay khi nhấn
                      side: WidgetStateProperty.all<BorderSide>(
                          const BorderSide(
                              color: Color.fromARGB(
                                  255, 137, 13, 4))), // Thiết lập màu viền
                    ),
                    child: const Text(TTexts.tContinue),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => controller.sendEmailVerification(),
                    child: const Text(TTexts.resendEmail),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
              ],
            ),
          ),
        ));
  }
}
