import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecome_clean/domain/order/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    super.cartItemId,
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

  /// 🔹 Chuyển từ JSON (Firestore hoặc API) sang Model
  factory OrderModel.fromJson(Map<String, dynamic> json, {String? cartItemId}) {
    // Nếu Firestore trả về Timestamp thì convert đúng cách
    DateTime createdDate;
    final createdValue = json['created_date'];

    if (createdValue is Timestamp) {
      createdDate = createdValue.toDate();
    } else if (createdValue is String) {
      createdDate = DateTime.tryParse(createdValue) ?? DateTime.now();
    } else {
      createdDate = DateTime.now();
    }

    return OrderModel(
      cartItemId: cartItemId ?? json['cart_item_id'],
      productId: json['product_id'] ?? '',
      productTitle: json['product_title'] ?? '',
      productQuantity: json['product_quantity'] ?? 0,
      productColor: json['product_color'] ?? '',
      productSize: json['product_size'] ?? '',
      productPrice: (json['product_price'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0.0,
      productImage: json['product_image'] ?? '',
      createdDate: createdDate,
    );
  }

  /// 🔹 Chuyển Model sang JSON (để lưu Firestore)
  @override
  Map<String, dynamic> toJson() {
    return {
      'cart_item_id': cartItemId, // ✅ thêm dòng này
      'product_id': productId,
      'product_title': productTitle,
      'product_quantity': productQuantity,
      'product_color': productColor,
      'product_size': productSize,
      'product_price': productPrice,
      'total_price': totalPrice,
      'product_image': productImage,
      'created_date': Timestamp.fromDate(
        createdDate,
      ), // ✅ dùng Timestamp cho Firestore
    };
  }

  /// 🔹 Tạo từ Entity (dùng trong Repository)
  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      cartItemId: entity.cartItemId,
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

  /// 🔹 Chuyển ngược lại sang Entity (khi đưa về tầng Domain/UI)
  OrderEntity toEntity() => OrderEntity(
    cartItemId: cartItemId,
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

  /// 🔹 Tạo bản copy (rất tiện khi cập nhật giỏ hàng)
  @override
  OrderModel copyWith({
    String? cartItemId,
    String? productId,
    String? productTitle,
    int? productQuantity,
    String? productColor,
    String? productSize,
    double? productPrice,
    double? totalPrice,
    String? productImage,
    DateTime? createdDate,
  }) {
    return OrderModel(
      cartItemId: cartItemId ?? this.cartItemId,
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      productQuantity: productQuantity ?? this.productQuantity,
      productColor: productColor ?? this.productColor,
      productSize: productSize ?? this.productSize,
      productPrice: productPrice ?? this.productPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      productImage: productImage ?? this.productImage,
      createdDate: createdDate ?? this.createdDate,
    );
  }
}
