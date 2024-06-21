
import 'package:TShop/common/shimmer/shimmer.dart';
import 'package:TShop/common/widgets/layouts/grid_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TBrandsShimmer extends StatelessWidget {
  const TBrandsShimmer({super.key,  this.itemCount=4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(itemCount: itemCount, itemBuilder: (_, __) => const TShimmerEffect(width: 300, height: 80), mainAxisExtent: 80,);
  }
}