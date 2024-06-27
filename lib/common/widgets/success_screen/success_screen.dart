import 'package:TShop/common/styles/spacing_styles.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/constants/text_string.dart';
import 'package:flutter/material.dart';

import '../../../utils/helpers/helper_functions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subtTitle,
      required this.onPressed});
  final String image, title, subtTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              ///Image
              Image(
                image: AssetImage(image),
                width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              ///Tittle and subtittle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              Text(
                subtTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              ///Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
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
                  child: const Text(TTexts.tContinue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
