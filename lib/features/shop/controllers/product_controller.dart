import 'package:TShop/data/repositories/product/product_repository.dart';
import 'package:TShop/features/shop/models/product_model.dart';
import 'package:TShop/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductController extends GetxController{
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featureProducts = <ProductModel>[].obs;

  @override 
  void onInit(){
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async{
    try{
      //Show loader while loading Products;
      isLoading.value = true;

      // Fetch Products
      final products = await productRepository.getFeaturedProducts();
      //Assign Products
      featureProducts.assignAll(products);
    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }
  
  // Get the product price or price range for variations
  String getProductPrice(ProductModel product){
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

    // If no variations exist, return the simple price or sale price
    if (product.productType == 'single') {
      double priceToConsider = product.salePrice > 0 ? product.salePrice : product.price;
      return formatter.format(priceToConsider);
    } else {
      // Calculate the smallest and largest prices among variations
      for (var variation in product.productVariations!) {
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // Update smallest and largest prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      if (smallestPrice == largestPrice) {
        return formatter.format(largestPrice);
      } else {
        return '${formatter.format(smallestPrice)} - ${formatter.format(largestPrice)}';
      }
    } 
}

  // Calulate Discount Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice){
    if(salePrice == null|| salePrice <= 0) return null;
    if(originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  // Check Product Stock Status
  String getProductStockStatus(int stock){
    return stock > 0 ? 'Có sẵn' : 'Hết hàng';
  }
}