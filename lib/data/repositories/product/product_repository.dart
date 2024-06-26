
import 'package:TShop/features/shop/models/product_model.dart';
import 'package:TShop/utils/exceptions/firebase_exceptions.dart';
import 'package:TShop/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  //Get limited featured products

  /// Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(40)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print('$e');
      throw 'Something went wrong. Please try again';
    }
  }


    /// Get limited featured products
  
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true).limit(40)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print('$e');
      throw 'Something went wrong. Please try again';
    }
  }


// Get products base on query
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final QuerySnapshot querySnapshot = await query.get();
      final List<ProductModel> productsList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productsList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print('General exception: $e');
      throw 'Something went wrong. Please try again';
    }
  }

// Get product for brands
  Future<List<ProductModel>> getProductsForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: int.parse(brandId))
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: int.parse(brandId))
              .limit(limit)
              .get();
      // print(brandId);
      // print(querySnapshot.docs);
      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      
      // print(products);

      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Get product for category
  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = -1}) async {
    try {
      final productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('CategoryId', isEqualTo: int.parse(categoryId))
              .get()
          : await _db
              .collection('ProductCategory')
              .where('CategoryId', isEqualTo: int.parse(categoryId))
              .limit(limit)
              .get();


      // Extract product ids
      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['ProductId'].toString())
          .toList();

      // Products query
      final productsQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      List<ProductModel> products = productsQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Upload dummy data to CloudFirebase

  // Future<void> uploadDummyData(List<ProductModel> products) async{
  //   try {
  //     // Upload all the products along with their images
  //     final storage = Get.put(TFirebaseStorageService());
  //     // Loop through each product
  //     for (var product in products) {
  //       // Get image data link from local assets
  //       final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);
  //       // Upload image and get its URL
  //       final url = await storage.uploadImageData('Products/Images', thumbnail, product.thumbnail.toString());
  //       // Assign URL to product.thumbnail attribute
  //       product.thumbnail = url;
  //       // Product list of images
  //       if (product.images != null && product.images!.isNotEmpty) {
  //         List<String> imagesUrl = [];
  //         for (var image in product.images!) {
  //           // Get image data link from local assets
  //           final assetImage = await storage.getImageDataFromAssets (image);
  //           // Upload image and get its URL
  //           final url = await storage.uploadImageData('Products/Images', assetImage, image);
  //           imagesUrl.add(url);
  //         }
  //         product.images!.clear();
  //         product.images!.addAll(imagesUrl);
  //     }

  //       // Upload Variation Images
  //       if (product.productType == ProductType.variable.toString()) {
  //         for (var variation in product.productVariations!) {
  //           // Get image data link from local assets
  //           final assetImage = await storage.getImageDataFromAssets (variation.image);
  //           // Upload image and get its URL
  //           final url = await storage.uploadImageData('Products/Images', assetImage, variation.image);
  //           // Assign URL to variation.image attribute
  //         variation.image = url;
  //         }
  //       }
  //       // Store product in Firestore
  //       await _db.collection ("Products").doc(product.id).set(product.toJson());
  //     }
  // } on FirebaseException catch (e) {
  //  throw e.message!;
  // } on SocketException catch (e) {
  //   throw e.message;
  // } on PlatformException catch (e) {
  //   throw e.message!;
  // } catch (e) {
  //      throw e.toString();
  // }
  // }
}
