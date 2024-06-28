import 'package:TShop/features/shop/controllers/product/variation_controller.dart';
import 'package:TShop/features/shop/models/cart_item_model.dart';
import 'package:TShop/features/shop/models/product_model.dart';
import 'package:TShop/utils/local_storage/storage_utility.dart';
import 'package:TShop/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // late final GetStorage _storage;

  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController(){
    loadCartItems();
  }

  void addToCart(ProductModel product) {
    // Quantity check
    if (productQuantityInCart.value < 0) {
      TLoaders.customToast(message: 'Hãy thêm sản phẩm');
      return;
    }

    // Variation selected?
    if (product.productType == 'Variable' &&
        variationController.selectedVariation.value.id.isEmpty) {
      TLoaders.customToast(message: 'Vui lòng chọn biến thể');
      return;
    }

    // out of stock
    if (product.productType == 'Variable') {
      if (variationController.selectedVariation.value.stock <= 0) {
        TLoaders.warningSnackBar(message: 'Sản phẩm đã hết hàng', title: 'Lỗi');
        return;
      }
    } else {
      if (product.stock < 1) {
        TLoaders.warningSnackBar(message: 'Sản phẩm đã hết hàng', title: 'Lỗi');
        return;
      }
    }

    // Convert product model to cart item model
    final selectedCartItem =
        convertToCartItem(product, productQuantityInCart.value);

    // Check if already added in cart
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);

    if (index > 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    TLoaders.customToast(message: 'Đã thêm sản phẩm vào giỏ hàng');
  }

  // Add one to cart
  void addOneToCart(CartItemModel item){
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId);

    if(index >=0){
      cartItems[index].quantity += 1;

    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  // remove one from cart
  void removeOneFromCart(CartItemModel item){
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId);
    // print(index);
    if(index >= 0 && cartItems[index].quantity>1){
      cartItems[index].quantity-=1;
    } else {
      cartItems[index].quantity == 1 ? removeFromCartDialog(index) : cartItems.removeAt(index);
    }
    updateCart();
  }


  void removeFromCartDialog(int index){
    Get.defaultDialog(
      title: 'Xóa sản phẩm',middleText: 'Bạn có chắc muốn xóa sản phẩm?', onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        TLoaders.customToast(message: "Đã xóa sản phẩm khỏi giỏ hàng");
        Get.back();
      },
      onCancel:  () => () =>  Get.back()
    );
  
  }

  void updateAlreadyAddedProductCount(ProductModel product){
    if(product.productType == 'Single'){
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      // get selected variation if any ...
      final variationId = variationController.selectedVariation.value.id;

      if(variationId.isNotEmpty){
        productQuantityInCart.value = getVariationQuantityInCart(product.id,  variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }

  // Convert product to cartitem
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == 'Single') {
      // reset varition in case of single product type
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0
            ? variation.salePrice
            : variation.originalPrice
        : product.salePrice > 0
            ? product.salePrice
            : product.originalPrice;
    
    print(product.salePrice);

    return CartItemModel(
        productId: product.id,
        quantity: quantity,
        title: product.title,
        price: price,
        variationId: variation.id,
        image: isVariation ? variation.image : product.thumbnail,
        brandName: product.brand != null ? product.brand?.name : '',
        selectedVariation: isVariation ? variation.attributeValues : null);
  }

  void updateCart() {
    updateCartTotal();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotal() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;
    for (var item in cartItems) {
      calculatedTotalPrice += ((item.price)! * item.quantity.toDouble());
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    // TLocalStorage.init('cartItems');
    TLocalStorage.instance().writeData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings =
        TLocalStorage.instance().readData<List<dynamic>>('cartItems');
        
    // ignore: deprecated_member_use //// LỖI CHỖ NÀY
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotal();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (item) =>
            item.productId == productId && item.variationId == variationId,
        orElse: () => CartItemModel.empty());
    return foundItem.quantity;
  }


  void clearCart(){
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

String formatPrice(double price) {
  final formatter = NumberFormat('#,###', 'vi_VN');
  return formatter.format(price);
}

}
