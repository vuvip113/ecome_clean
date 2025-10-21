import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecome_clean/domain/product/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.productId,
    required super.title,
    required super.categoryId,
    required super.colors,
    required super.createdDate,
    required super.gender,
    required super.images,
    required super.price,
    required super.discountedPrice,
    required super.salesNumber,
    required super.sizes,
  });

  /// 🔹 Firestore → Model
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] ?? '',
      title: map['title'] ?? '',
      categoryId: map['categoryId'] ?? '',
      colors: (map['colors'] as List<dynamic>? ?? [])
          .map((e) => ProductColorModel.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      createdDate: _toDate(map['createdDate']),
      gender: map['gender'] ?? 3,
      images: List<String>.from(map['images'] ?? []),
      price: _toDouble(map['price']),
      discountedPrice: _toDouble(map['discountedPrice']),
      salesNumber: map['salesNumber'] ?? 0,
      sizes: List<String>.from(map['sizes'] ?? []),
    );
  }

  /// 🔹 Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'categoryId': categoryId,
      'colors': colors.map((c) {
        if (c is ProductColorModel) return c.toMap();
        return ProductColorModel(title: c.title, rgb: c.rgb).toMap();
      }).toList(),
      'createdDate': Timestamp.fromDate(createdDate),
      'gender': gender,
      'images': images,
      'price': price,
      'discountedPrice': discountedPrice,
      'salesNumber': salesNumber,
      'sizes': sizes,
    };
  }

  /// 🔹 Helper: Convert Timestamp/String → DateTime
  static DateTime _toDate(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }

  /// 🔹 Helper: Convert dynamic → double
  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}

/// 🔸 Model con cho ProductColor (đồng bộ với Entity)
class ProductColorModel extends ProductColor {
  const ProductColorModel({required super.title, required super.rgb});

  factory ProductColorModel.fromMap(Map<String, dynamic> map) {
    return ProductColorModel(
      title: map['title'] ?? '',
      rgb: List<int>.from(map['rgb'] ?? [0, 0, 0]),
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'rgb': rgb};
  }
}
