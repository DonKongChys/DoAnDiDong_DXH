// ignore_for_file: public_member_api_docs, sort_constructors_first

class CartItemModel {
  String productId;
  String title;
  double? price;
  String? image;
  int quantity;
  String? variationId;
  String? brandName;
  Map<String, dynamic>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.quantity,
    required this.title,
    this.price,
    this.image,
    this.variationId,
    this.brandName,
    this.selectedVariation,
  });

  // Emptycart
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0, title: '');

  // Convert a Cartitem to a json map
  Map<String, dynamic> toJson() {
    return {
      'ProductId': productId,
      'Title': title,
      'Image': image,
      'Quantity': quantity,
      'VariationId': variationId,
      'BrandName': brandName,
      'SelectedVariation': selectedVariation,
      'Price': price
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['ProductId'],
      title: json['Title'],
      image: json['Image'],
      quantity: json['Quantity'],
      variationId: json['VariationId'],
      brandName: json['BrandName'],
      selectedVariation: json['SelectedVariation'],
      price: json['Price'],
    );
  }
}
