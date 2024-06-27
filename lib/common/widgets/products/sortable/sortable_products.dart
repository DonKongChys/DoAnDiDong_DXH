import 'package:TShop/common/widgets/layouts/grid_layout.dart';
import 'package:TShop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:TShop/features/shop/controllers/all_products_controller.dart';
import 'package:TShop/features/shop/models/product_model.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({super.key, required this.products});

  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        ///Drop down
        DropdownButtonFormField(
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            controller.sortProducts(value!);
          },
          decoration: const InputDecoration(icon: Icon(Iconsax.sort)),
          
          items: [
            'Tên',
            'Giá gốc',
            'Giá khuyến mãi',
            'Sale',
            'Mới nhất',
            'Phổ biến'
          ]
              .map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        Obx(
          () => TGridLayout(
              itemCount:controller.products.length,
              itemBuilder: (_, index) =>
                  TProductCardVertical(product: controller.products[index])),
        )
      ],
    );
  }
}
