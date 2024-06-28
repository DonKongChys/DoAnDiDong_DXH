import 'package:TShop/features/personalization/controllers/address_controller.dart';
import 'package:TShop/features/shop/controllers/product/checkout_controller.dart';
import 'package:TShop/features/shop/controllers/product/variation_controller.dart';
import 'package:TShop/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AddressController());
    Get.put(CheckoutController());
    Get.put(VariationController());
  }
}
