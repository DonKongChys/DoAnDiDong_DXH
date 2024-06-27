import 'dart:convert';

import 'package:TShop/data/repositories/product/product_repository.dart';
import 'package:TShop/features/shop/models/product_model.dart';
import 'package:TShop/utils/local_storage/storage_utility.dart';
import 'package:TShop/utils/popups/loaders.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  /// Variables
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourite();
  }

  // Method to initialize favourites by reading from storage
  Future<void> initFavourite() async {
    final json = TLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      TLoaders.customToast(
          message: 'Sản phẩm đã được thêm vào danh sách yêu thích.');
    } else {
      TLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
            TLoaders.customToast(
          message: 'Sản phẩm đã được loại bỏ khỏi danh sách yêu thích.');
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    TLocalStorage.instance().writeData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance.getFavouriteProducts(favorites.keys.toList());
  }

}
