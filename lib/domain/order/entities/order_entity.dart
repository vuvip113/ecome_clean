import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
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
}
