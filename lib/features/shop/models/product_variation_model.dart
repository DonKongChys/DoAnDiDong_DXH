
class ProductVariationModel { 
  final String id; String sku;
  String image;
  String? description;
  double originalPrice;
  double salePrice;
  int stock;
  Map<String, dynamic> attributeValues;
  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.originalPrice = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
});
  /// Create Empty func for clean code
  static ProductVariationModel empty() => ProductVariationModel(id: '', attributeValues: {});

  // Json Format
  toJson(){
    return {
      'Id': id,
      'SKU': sku,
      'Image': image,
      'Description': description,
      'OriginalPrice': originalPrice,
      'SalePrice': salePrice,
      'Stock': stock,
      'AttributeValues': attributeValues,
    };
  }


  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductVariationModel.fromJson (Map<String, dynamic> document) {
    final data=document;
    if(data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
      id: (data['Id'] ?? '').toString(),
      originalPrice: double.parse((data['OriginalPrice'] ?? 0.0).toString().replaceAll('.', '')),
      sku: data['SKU'] ?? '',
      stock: data['Stock'] ?? 0,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString().replaceAll('.', '')), 
      image: data['Image'] ?? '',
      attributeValues: Map<String, dynamic>.from(data['AttributeValues']),
    ); 
  }
}