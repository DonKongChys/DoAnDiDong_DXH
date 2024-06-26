
import 'package:TShop/data/repositories/product/product_repository.dart';
import 'package:TShop/features/shop/models/brand_model.dart';
import 'package:TShop/features/shop/models/product_model.dart';
import 'package:TShop/utils/exceptions/firebase_exceptions.dart';
import 'package:TShop/utils/exceptions/format_exceptions.dart';
import 'package:TShop/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Get all brands
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final list = snapshot.docs
          .map((document) => BrandModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Lỗi ở đâu đó rồi, hãy thử lại sau nhé';
    }
  }

  // Uploadvia dummyfile

  // Get brand for category
  Future<List<BrandModel>> getBrandForCategory(String categoryId) async {
    try {
      QuerySnapshot brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('CategoryId', isEqualTo: int.parse(categoryId))
          .get();
      
      // print(brandCategoryQuery.docs.length);
      // Extract brand id from document
      List<String> brandIds = brandCategoryQuery.docs
          .map((doc) => doc['BrandId'].toString())
          .toList();

      // print(brandIds);
      // Query get all documents where the brand id in list brandIds, feilpath document id to query documnet in collection
      final brandsQuery = await _db
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(2)
          .get();

      // extract data from document
      List<BrandModel> brands =
          brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      // print(brands);
      return brands;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Lỗi!';
    }
  }

  // Get brands specific product from data source
  Future<List<ProductModel>> getBrandProducts(String brandId) async {
    try {
      final products = await ProductRepository.instance.getProductsForBrand(brandId: brandId);
      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Lỗi!';
    }
  }
}
