import 'package:TShop/features/shop/models/product_attribute_model.dart';
import 'package:TShop/features/shop/models/product_variation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel { 
    String id; 
    int stock;
    String? sku;
    double price;
    String title;
    DateTime? date;
    double salePrice;
    String thumbnail;
    bool? isFeatured;
    String brand;
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
        required this.price,
        required this.title,
        required this.brand,
        this.date,
        this.salePrice = 0.0,
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
  static ProductModel empty() => ProductModel(id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '',  brand: '');
  /// Json Format
  toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images ?? [], 
      'Thumbnail': thumbnail,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Branch': brand,
      // 'Brand': brand!.toJson(), 
      'Description': description,
      'ProductType': productType,
      'ProductAttributes': productAttributes != null ? productAttributes!.map((e) => e.toJson()).toList() : [], 
      'ProductVariations': productVariations != null ? productVariations!.map((e) => e.toJson()).toList() : [],
      };
  }
  
  /// Map Json oriented document snapshot from Firebase to Model
factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
  if(document.data() == null) return ProductModel.empty();
  final data = document.data()!;
  return ProductModel(
    id: document.id,
    sku: data['SKU'],
    title: data['Title'],
    stock: data['Stock'] ?? 0,
    isFeatured: data['IsFeatured'] ?? false,
    price: double.parse((data['Price'] ?? 0.0).toString()),
    salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
    thumbnail: data['Thumbnail'] ?? '',
    categoryId: data['CategoryId'] ?? '',
    description: data['Description'] ?? '',
    brand: data['Brand'] ?? '',
    productType: data['ProductType'] ?? '',
    // brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
    images: data['Images'] != null ? List<String>.from(data['Images']) : [],
    productAttributes: data['ProductAttributes'] != null 
        ? (data['ProductAttributes'] as List<dynamic>)
            .map((e) => ProductAttributeModel.fromJson(e as Map<String, dynamic>))
            .toList()
        : [],
    productVariations: data['ProductVariations'] != null 
        ? (data['ProductVariations'] as List<dynamic>)
            .map((e) => ProductVariationModel.fromJson(e as Map<String, dynamic>))
            .toList()
        : [],
  );
}


}
