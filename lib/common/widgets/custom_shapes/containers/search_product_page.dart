import 'package:TShop/utils/constants/colors.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSearchContainer1 extends StatelessWidget {
  const TSearchContainer1(
      {super.key,
      required this.textController,
      this.icon = Iconsax.search_normal,
      this.showBackground = true,
      this.showBorder = true,
      this.onChanged,
      this.padding =
          const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace)});

  final TextEditingController textController;
  final IconData? icon;
  final bool showBackground, showBorder;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: padding,
      child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          // padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                    ? TColors.dark
                    : TColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            // border: showBorder ? Border.all(color: TColors.grey) : null,
          ),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: textController,
                onChanged: onChanged,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white, 
                  hintText: "Nhập sản phẩm...",
                  border: InputBorder.none,
                  prefixIcon: Icon(Iconsax.search_normal, color: Colors.grey),
                  // contentPadding: EdgeInsets.zero, 
                  contentPadding: EdgeInsets.symmetric(vertical: 19.0),
                ),
              ),
            ),
          ])),
    );
  }
}
