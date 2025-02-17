import 'package:TShop/common/widgets/appbar/appbar.dart';
import 'package:TShop/features/personalization/controllers/update_name_controller.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/constants/text_string.dart';
import 'package:TShop/utils/validations/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(

        /// Custom Appbar
        appBar: TAppBar(
          showBackArrow: true,
          title:
              Text('Đổi tên', style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Headlings
              Text(
                'Sử dụng tên thật để dễ dàng xác minh. Tên này sẽ xuất hiện trên một số trang.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Text field and Button
              Form(
                  key: controller.updateUserNameFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.firstName,
                        validator: (value) =>
                            TValidator.validateEmptyText('First name', value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: TTexts.firstName,
                            prefixIcon: Icon(Iconsax.user)),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: controller.lastName,
                        validator: (value) =>
                            TValidator.validateEmptyText('Last name', value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: TTexts.lastName,
                            prefixIcon: Icon(Iconsax.user)),
                      )
                    ],
                  )),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.updateUserName(),
                  style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromARGB(
                                      255, 145, 14, 4)), // Thiết lập màu nền
                              overlayColor: WidgetStateProperty.all<Color>(Colors
                                  .red
                                  .shade200), // Thiết lập màu overlay khi nhấn
                              side: WidgetStateProperty.all<BorderSide>(
                                  const BorderSide(
                                      color: Color.fromARGB(255, 137, 13,
                                          4))), // Thiết lập màu viền
                            ),
                  child: const Text('Lưu'),
                ),
              )
            ],
          ),
        ));
  }
}
