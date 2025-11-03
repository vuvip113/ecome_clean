import 'package:ecome_clean/domain/order/entities/order_status_entity.dart';
import 'package:ecome_clean/domain/order/entities/product_order_entity.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String code;
  final DateTime createdDate;
  final int itemCount;
  final String orderId;
  final List<OrderStatusEntity> orderStatus;
  final List<ProductOrderEntity> products;
  final String shippingAddress;
  final double totalAmount;

  const OrderEntity({
    required this.code,
    required this.createdDate,
    required this.itemCount,
    required this.orderId,
    required this.orderStatus,
    required this.products,
    required this.shippingAddress,
    required this.totalAmount,
  });

  @override
  List<Object?> get props => [
    code,
    createdDate,
    itemCount,
    orderId,
    orderStatus,
    products,
    shippingAddress,
    totalAmount,
  ];
}
