import 'package:TShop/common/widgets/success_screen/success_screen.dart';
import 'package:TShop/data/repositories/authentication/authentication_repository.dart';
import 'package:TShop/data/repositories/orders/order_repository.dart';
import 'package:TShop/features/personalization/controllers/address_controller.dart';
import 'package:TShop/features/shop/controllers/cart_controller.dart';
import 'package:TShop/features/shop/controllers/product/checkout_controller.dart';
import 'package:TShop/features/shop/models/order_model.dart';
import 'package:TShop/navigation_menu.dart';
import 'package:TShop/utils/constants/enums.dart';
import 'package:TShop/utils/constants/image_string.dart';
import 'package:TShop/utils/popups/full_screen_loader.dart';
import 'package:TShop/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  ///variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  ///Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoaders.warningSnackBar(title: '0h Snap!', message: e.toString());
      return [];
    }
  }

  /// add method for processing
  void processOrder(double totalAmount) async {
    try {
// Start Loader
      TFullScreenLoader.openLoadingDialog(
          'Processing your order', TImages.pencilAnimation);

// Get user authentication Id
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) return;

// Add Details
      final order = OrderModel(
        // Generate a unique ID for the order
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        // set date as need
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.value,
      );

      // Save order to the firestore
      await orderRepository.saveOrder(order, userId);

      //update cart status
      cartController.clearCart();

      //show success screen
      Get.off(() => SuccessScreen(
          image: TImages.orderCompletedAnimation,
          title: 'Thanh toán thành công!',
          subtTitle: 'Đơn hàng của bạn sẽ được gửi đến sớm nhất!',
          onPressed: () => Get.offAll(() => const NavigationMenu())));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
