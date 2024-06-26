import 'package:TShop/data/repositories/brands/brand_repository.dart';
import 'package:TShop/data/repositories/product/product_repository.dart';
import 'package:TShop/features/shop/models/brand_model.dart';
import 'package:TShop/features/shop/models/product_model.dart';
import 'package:TShop/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;

  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  Future<void> getFeaturedBrands() async {
    try {
      // Show loader when loading brands
      isLoading.value = true;
      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);

      featuredBrands.assignAll(allBrands
          .where((brand) => brand.isFeatured ?? false)
          .take(4));
    } catch (e) {
      TLoaders.errorSnackBar(title: "Lỗi! when loading brands", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Get brands for category
  Future<List<BrandModel>> getBrandForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandForCategory(categoryId);
      // print(brands);
      return brands;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Lỗi  Get brands for category', message: e.toString());
      return [];
    }
  }

  // Get brand products
  Future<List<ProductModel>> getBrandProducts({required String brandId, int limit = -1}) async {
    try {
      final products =
          ProductRepository.instance.getProductsForBrand(brandId: brandId);
      print(brandId);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Lỗi  Get brand products', message: e.toString());
      return [];
    }
  }
}
