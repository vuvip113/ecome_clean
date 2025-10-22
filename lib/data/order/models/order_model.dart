import 'package:ecome_clean/domain/order/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.productId,
    required super.productTitle,
    required super.productQuantity,
    required super.productColor,
    required super.productSize,
    required super.productPrice,
    required super.totalPrice,
    required super.productImage,
    required super.createdDate,
  });

  /// Chuyển từ JSON sang Model
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      productId: json['product_id'] as String,
      productTitle: json['product_title'] as String,
      productQuantity: json['product_quantity'] as int,
      productColor: json['product_color'] as String,
      productSize: json['product_size'] as String,
      productPrice: (json['product_price'] as num).toDouble(),
      totalPrice: (json['total_price'] as num).toDouble(),
      productImage: json['product_image'] as String,
      createdDate: DateTime.parse(json['created_date'] as String),
    );
  }

  /// Chuyển Model sang JSON (để gửi API)
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_title': productTitle,
      'product_quantity': productQuantity,
      'product_color': productColor,
      'product_size': productSize,
      'product_price': productPrice,
      'total_price': totalPrice,
      'product_image': productImage,
      'created_date': createdDate.toIso8601String(),
    };
  }

  /// Tạo từ Entity (nếu cần dùng trong tầng Data)
  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      productId: entity.productId,
      productTitle: entity.productTitle,
      productQuantity: entity.productQuantity,
      productColor: entity.productColor,
      productSize: entity.productSize,
      productPrice: entity.productPrice,
      totalPrice: entity.totalPrice,
      productImage: entity.productImage,
      createdDate: entity.createdDate,
    );
  }

  /// Chuyển sang Entity (nếu cần truyền sang tầng Domain)
  OrderEntity toEntity() => OrderEntity(
    productId: productId,
    productTitle: productTitle,
    productQuantity: productQuantity,
    productColor: productColor,
    productSize: productSize,
    productPrice: productPrice,
    totalPrice: totalPrice,
    productImage: productImage,
    createdDate: createdDate,
  );
}
