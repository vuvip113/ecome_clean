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
      colors: (map['colors'] as List<dynamic>?)
              ?.map((e) => ProductColorModel.fromMap(e))
              .toList() ??
          [],
      createdDate: _toDate(map['createdDate']),
      gender: map['gender'] ?? 0,
      images: List<String>.from(map['images'] ?? []),
      price: map['price']?.toString() ?? '0',
      discountedPrice: map['discountedPrice']?.toString() ?? '0',
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
      'colors': colors.map((c) => (c as ProductColorModel).toMap()).toList(),
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
}

/// 🔸 Model cho ProductColor
class ProductColorModel extends ProductColor {
  const ProductColorModel({
    required super.hexCode,
    required super.title,
  });

  factory ProductColorModel.fromMap(Map<String, dynamic> map) {
    return ProductColorModel(
      hexCode: map['hexCode'] ?? '',
      title: map['title'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hexCode': hexCode,
      'title': title,
    };
  }
}
