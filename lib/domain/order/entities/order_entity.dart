import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String? cartItemId; // 🔹 ID của document trong Firestore
  final String productId;
  final String productTitle;
  final int productQuantity;
  final String productColor;
  final String productSize;
  final double productPrice;
  final double totalPrice;
  final String productImage;
  final DateTime createdDate;

  const OrderEntity({
    this.cartItemId, // có thể null khi thêm mới
    required this.productId,
    required this.productTitle,
    required this.productQuantity,
    required this.productColor,
    required this.productSize,
    required this.productPrice,
    required this.totalPrice,
    required this.productImage,
    required this.createdDate,
  });

  @override
  List<Object?> get props => [
    cartItemId,
    productId,
    productTitle,
    productQuantity,
    productColor,
    productSize,
    productPrice,
    totalPrice,
    productImage,
    createdDate,
  ];

  /// 🔹 Copy để tạo bản mới (hữu ích khi cập nhật giỏ hàng)
  OrderEntity copyWith({
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
    return OrderEntity(
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
