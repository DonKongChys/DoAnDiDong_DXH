
import 'package:TShop/common/widgets/appbar/appbar.dart';
import 'package:TShop/features/shop/screens/order/widgets/orders_list.dart';
import 'package:TShop/utils/constants/size.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('My Orders', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),

        /// Order List Items
        child: TOrderListItems()
      )
    );
  }
}