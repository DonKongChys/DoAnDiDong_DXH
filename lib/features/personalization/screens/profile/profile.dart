import 'package:TShop/common/widgets/appbar/appbar.dart';
import 'package:TShop/common/widgets/images/t_circular_image.dart';
import 'package:TShop/common/widgets/texts/section_heading.dart';
import 'package:TShop/features/personalization/controllers/user_controller.dart';
import 'package:TShop/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:TShop/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:TShop/utils/constants/image_string.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/custom_shimmer/t_shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar:
          const TAppBar(showBackArrow: true, title: Text('Chi tiết tài khoản')),

      /// -- Body
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Profile Picture
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Obx(() {
                          final networkImage =
                              controller.user.value.profilePicture;
                          final image = networkImage.isNotEmpty
                              ? networkImage
                              : TImages.user;
                          return controller.imageUploading.value
                              ? const TShimmerEffect(
                                  width: 80, height: 80, radius: 80)
                              : TCircularImage(
                                  image: image,
                                  width: 80,
                                  height: 80,
                                  isNetworkImage: networkImage.isNotEmpty);
                        }),
                        TextButton(
                            onPressed: () =>
                                controller.uploadUserProfilePicture(),
                            child: const Text('Thay đổi ảnh'))
                      ],
                    ),
                  ),

                  /// Details
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  /// Heading Profile Info
                  const TSectionHeading(
                    title: 'Thông tin hồ sơ',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  TProfileMenu(
                    title: 'Họ tên',
                    value: controller.user.value.fullName,
                    onPressed: () => Get.to(() => const ChangeName()),
                  ),
                  TProfileMenu(
                    title: 'Username',
                    value: controller.user.value.username,
                    onPressed: () {},
                  ),

                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  /// Heading Personal Info
                  const TSectionHeading(
                    title: 'Thông tin cá nhân',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  TProfileMenu(
                    title: 'User ID',
                    value: controller.user.value.id,
                    icon: Iconsax.copy,
                    onPressed: () {},
                  ),
                  TProfileMenu(
                    title: 'E-mail',
                    value: controller.user.value.email,
                    onPressed: () {},
                  ),
                  TProfileMenu(
                    title: 'Số điện thoại',
                    value: controller.user.value.phoneNumber,
                    onPressed: () {},
                  ),
                  TProfileMenu(
                    title: 'Giới tính',
                    value: 'Nam',
                    onPressed: () {},
                  ),
                  TProfileMenu(
                    title: 'Ngày sinh',
                    value: '10 Oct, 1994',
                    onPressed: () {},
                  ),
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  Center(
                      child: TextButton(
                          onPressed: () =>
                              controller.deleteAccountWarningPopup(),
                          child: const Text('Xóa tài khoản',
                              style: TextStyle(color: Colors.red))))
                ],
              ))),
    );
  }
}
