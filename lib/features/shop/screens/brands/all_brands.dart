import 'package:TShop/common/shimmer/brand_shimmer.dart';
import 'package:TShop/common/widgets/appbar/appbar.dart';
import 'package:TShop/common/widgets/brands/brand_card.dart';
import 'package:TShop/common/widgets/layouts/grid_layout.dart';
import 'package:TShop/common/widgets/texts/section_heading.dart';
import 'package:TShop/features/shop/controllers/brand_controller.dart';
import 'package:TShop/features/shop/screens/brands/brand_products.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
        appBar: const TAppBar(
          title: Text("Brands"),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                ///Heading
                const TSectionHeading(title: "Brands"),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                ///Brand
                Obx(
                  ()  {
                    if(brandController.isLoading.value) return const TBrandsShimmer();

                    if(brandController.allBrands.isEmpty) {
                      return Center(child: Text('Không có dữ liệu', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),);
                    }

                   return TGridLayout(
                    itemCount: brandController.allBrands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (_, index) {
                      final brand = brandController.allBrands[index];
                     return TBrandCard(
                      showBorder: true,
                      onTap: () => Get.to(() =>  BrandProducts(brand: brand,)),
                      brand: brand,
                    );
                    }
                  );
                  }
                )
              ],
            ),
          ),
        ));
  }
}
