import 'package:TShop/common/widgets/appbar/appbar.dart';
import 'package:TShop/features/personalization/controllers/address_controller.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/validations/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    return Scaffold(
        appBar:
            const TAppBar(showBackArrow: true, title: Text('Thêm địa chỉ mới')),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Form(
                  key: controller.addressFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: controller.name,
                        validator: (value) =>
                            TValidator.validateEmptyText('Name', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user),
                            labelText: 'Số địa chỉ'),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: controller.phoneNumber,
                        validator: TValidator.validatePhoneNumber,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.mobile),
                            labelText: 'Số điện thoại'),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.street,
                              validator: (value) =>
                                  TValidator.validateEmptyText('Street', value),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.building_31),
                                  labelText: 'Tên đường'),
                            ),
                          ),
                          const SizedBox(width: TSizes.spaceBtwInputFields),
                          Expanded(
                            child: TextFormField(
                              controller: controller.postalCode,
                              validator: (value) =>
                                  TValidator.validateEmptyText(
                                      'Postal Code', value),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.code),
                                  labelText: 'Mã bưu điện'),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.city,
                              validator: (value) =>
                                  TValidator.validateEmptyText('City', value),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.building),
                                  labelText: 'Thành phố/Huyện'),
                            ),
                          ),
                          const SizedBox(width: TSizes.spaceBtwInputFields),
                          Expanded(
                            child: TextFormField(
                              controller: controller.state,
                              validator: (value) =>
                                  TValidator.validateEmptyText('State', value),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.activity),
                                  labelText: 'Tỉnh'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      TextFormField(
                        controller: controller.country,
                        validator: (value) =>
                            TValidator.validateEmptyText('Country', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.global),
                            labelText: 'Quốc gia'),
                      ),
                      const SizedBox(
                        height: TSizes.defaultSpace,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: controller.addNewAddress,
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
                            child: const Text('Lưu')),
                      )
                    ],
                  ))),
        ));
  }
}
