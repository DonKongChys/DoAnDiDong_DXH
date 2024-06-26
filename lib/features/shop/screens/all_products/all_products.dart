import 'package:TShop/common/shimmer/vertical_product_shimmer.dart';
import 'package:TShop/common/widgets/appbar/appbar.dart';
import 'package:TShop/common/widgets/products/sortable/sortable_products.dart';
import 'package:TShop/features/shop/controllers/all_products_controller.dart';
import 'package:TShop/features/shop/models/product_model.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:TShop/utils/helpers/cloud_helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());

    return Scaffold(
      appBar:  TAppBar(
        title: Text(title),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {
              // Check state of future builder snapshot
              const loader = TVerticalProductShimmer();
              final widget = TCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot, loader: loader);

              if (widget != null) return widget;

              // Products found
              final products = snapshot.data!;

              return TSortableProducts(products: products);
            },
          ),
        ),
      ),
    );
  }
}
