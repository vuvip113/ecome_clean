import 'package:ecome_clean/data/order/models/order_model.dart';
import 'package:ecome_clean/domain/order/entities/product_order_entity.dart';

class ProductOrderModel extends ProductOrderEntity {
  const ProductOrderModel({
    required super.cartItemId,
    required super.createdDate,
    required super.productColor,
    required super.productId,
    required super.productImage,
    required super.productPrice,
    required super.productQuantity,
    required super.productSize,
    required super.productTitle,
    required super.totalPrice,
  });

  factory ProductOrderModel.fromMap(Map<String, dynamic> map) {
    return ProductOrderModel(
      cartItemId: map['cart_item_id'] ?? '',
      createdDate: OrderModel.parseDate(map['created_date']),
      productColor: map['product_color'] ?? '',
      productId: map['product_id'] ?? '',
      productImage: map['product_image'] ?? '',
      productPrice: OrderModel.toDouble(map['product_price']),
      productQuantity: map['product_quantity'] ?? 0,
      productSize: map['product_size'] ?? '',
      productTitle: map['product_title'] ?? '',
      totalPrice: OrderModel.toDouble(map['total_price']),
    );
  }

  factory ProductOrderModel.fromEntity(ProductOrderEntity entity) {
    return ProductOrderModel(
      cartItemId: entity.cartItemId,
      createdDate: entity.createdDate,
      productColor: entity.productColor,
      productId: entity.productId,
      productImage: entity.productImage,
      productPrice: entity.productPrice,
      productQuantity: entity.productQuantity,
      productSize: entity.productSize,
      productTitle: entity.productTitle,
      totalPrice: entity.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cart_item_id': cartItemId,
      'created_date': createdDate.toIso8601String(),
      'product_color': productColor,
      'product_id': productId,
      'product_image': productImage,
      'product_price': productPrice,
      'product_quantity': productQuantity,
      'product_size': productSize,
      'product_title': productTitle,
      'total_price': totalPrice,
    };
  }

  ProductOrderModel copyWith({
    String? cartItemId,
    DateTime? createdDate,
    String? productColor,
    String? productId,
    String? productImage,
    double? productPrice,
    int? productQuantity,
    String? productSize,
    String? productTitle,
    double? totalPrice,
  }) {
    return ProductOrderModel(
      cartItemId: cartItemId ?? this.cartItemId,
      createdDate: createdDate ?? this.createdDate,
      productColor: productColor ?? this.productColor,
      productId: productId ?? this.productId,
      productImage: productImage ?? this.productImage,
      productPrice: productPrice ?? this.productPrice,
      productQuantity: productQuantity ?? this.productQuantity,
      productSize: productSize ?? this.productSize,
      productTitle: productTitle ?? this.productTitle,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  factory ProductOrderModel.fromJson(
    Map<String, dynamic> json, {
    String? cartItemId,
  }) {
    return ProductOrderModel(
      cartItemId: cartItemId ?? json['cart_item_id'] ?? '',
      createdDate: OrderModel.parseDate(json['created_date']),
      productColor: json['product_color'] ?? '',
      productId: json['product_id'] ?? '',
      productImage: json['product_image'] ?? '',
      productPrice: OrderModel.toDouble(json['product_price']),
      productQuantity: json['product_quantity'] ?? 0,
      productSize: json['product_size'] ?? '',
      productTitle: json['product_title'] ?? '',
      totalPrice: OrderModel.toDouble(json['total_price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_item_id': cartItemId,
      'created_date': createdDate.toIso8601String(),
      'product_color': productColor,
      'product_id': productId,
      'product_image': productImage,
      'product_price': productPrice,
      'product_quantity': productQuantity,
      'product_size': productSize,
      'product_title': productTitle,
      'total_price': totalPrice,
    };
  }

  ProductOrderEntity toEntity() {
    return ProductOrderEntity(
      cartItemId: cartItemId,
      createdDate: createdDate,
      productColor: productColor,
      productId: productId,
      productImage: productImage,
      productPrice: productPrice,
      productQuantity: productQuantity,
      productSize: productSize,
      productTitle: productTitle,
      totalPrice: totalPrice,
    );
  }

}
