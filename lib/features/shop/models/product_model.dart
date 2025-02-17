import 'package:TShop/features/shop/models/brand_model.dart';
import 'package:TShop/features/shop/models/product_attribute_model.dart';
import 'package:TShop/features/shop/models/product_variation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double originalPrice;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  // String brand;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.stock,
    this.sku,
    required this.originalPrice,
    required this.title,
    this.brand,
    this.date,
    this.salePrice = 0,
    required this.thumbnail,
    this.isFeatured,
    this.description,
    this.categoryId,
    this.images,
    required this.productType,
    this.productAttributes,
    this.productVariations,
  });

  /// Create Empty func for clean code
  static ProductModel empty() => ProductModel(
        id: '',
        title: '',
        stock: 0,
        originalPrice: 0,
        thumbnail: '',
        productType: '',
      );

  /// Json Format
  toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'OriginalPrice': originalPrice,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      // 'Brand': brand,
      'Brand': brand!.toJson(),
      'Description': description,
      'ProductType': productType,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;
    return ProductModel(
      id: document.id.toString(),
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      originalPrice: double.parse((data['OriginalPrice'] ?? '0').toString()),
      salePrice: double.parse((data['SalePrice'] ?? '0').toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: (data['CategoryId'] ?? '').toString(),
      description: data['Description'] ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      productType: data['ProductType'] ?? '',
      // brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>)
              .map((e) =>
                  ProductAttributeModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>)
              .map((e) =>
                  ProductVariationModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  // Map json oriented document snapshot from firebase  to model
  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return ProductModel(
      id: document.id.toString(),
      sku: (data['SKU'] ?? '').toString(),
      title: (data['Title'] ?? '').toString(),
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      originalPrice: double.parse((data['OriginalPrice'] ?? '0').toString()),
      salePrice: double.parse((data['SalePrice'] ?? '0').toString()),
      thumbnail: (data['Thumbnail'] ?? '').toString(),
      categoryId: (data['CategoryId'] ?? '').toString(),
      description: (data['Description'] ?? '').toString(),
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      productType: (data['ProductType'] ?? '').toString(),
      // brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>)
              .map((e) =>
                  ProductAttributeModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>)
              .map((e) =>
                  ProductVariationModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

//     factory ProductModel.fromQuerySnapshot(
//       QueryDocumentSnapshot<Object?> document) {
//     final data = document.data() as Map<String, dynamic>;

//     return ProductModel(
//         id: document.id,
//         sku: data['SKU'] ?? '',
//         title: data['Title'] ?? '',
//         stock: data['Stock'] ?? 0,
//         isFeatured: data['IsFeatured'] ?? false,
//         originalPrice: double.parse((data['OriginalPrice'] ?? '0').toString()),
//         salePrice: double.parse((data['SalePrice'] ?? '0').toString()),
//         thumbnail: data['Thumbnail'] ?? '',
//         categoryId: data['CategoryId'] ?? '',
//         description: data['Description'] ?? '',
//         brand: BrandModel.fromJson(data['Brand']),
//         productType: data['ProductType'],
//         images: data['Images'] != null ? List<String>.from(data['Images']) : [],
//         productAttributes: ((data['ProductAttributes'] as List<dynamic>)
//             .map((e) => ProductAttributeModel.fromJson(e))).toList(),
//         productVariations: ((data['ProductVariations'] as List<dynamic>)
//             .map((e) => ProductVariationModel.fromJson(e))).toList());
//   }
}
