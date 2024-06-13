import 'package:TShop/common/shimmer/boxes_shimmer.dart';
import 'package:TShop/common/widgets/brands/brand_show_case.dart';
import 'package:TShop/features/shop/controllers/brand_controller.dart';
import 'package:TShop/features/shop/models/category_model.dart';
import 'package:TShop/common/shimmer/list_tile_shimmer.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandForCategory(category.id),
        builder: (context, snapshot) {
          const loader = Column(
            children: [
              TListTileShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TBoxesShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            ],
          );
          final widget = TCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;

          final brands = snapshot.data!;

          return ListView.builder(itemBuilder: (_, index){
            final brand = brands[index];
            return  FutureBuilder(
              future: controller.getBrandProducts(brandId: brand.id, limit: 3),
              builder: (context, snapshot) {
                
                // Handle loader
                final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

                if (widget!=null) return widget;

                // Found record 
                final products = snapshot.data!;
                return TBrandShowcase(brand: brand, images: products.map((e) => e.thumbnail).toList(),);
              }
            );
          });

          
        });
  }
}
