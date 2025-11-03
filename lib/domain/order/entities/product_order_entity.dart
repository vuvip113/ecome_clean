import 'package:equatable/equatable.dart';

class ProductOrderEntity extends Equatable {
  final String cartItemId;
  final DateTime createdDate;
  final String productColor;
  final String productId;
  final String productImage;
  final double productPrice;
  final int productQuantity;
  final String productSize;
  final String productTitle;
  final double totalPrice;

  const ProductOrderEntity({
    required this.cartItemId,
    required this.createdDate,
    required this.productColor,
    required this.productId,
    required this.productImage,
    required this.productPrice,
    required this.productQuantity,
    required this.productSize,
    required this.productTitle,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [
    cartItemId,
    createdDate,
    productColor,
    productId,
    productImage,
    productPrice,
    productQuantity,
    productSize,
    productTitle,
    totalPrice,
  ];
}
