import 'package:ecome_clean/domain/order/entities/order_entity.dart';
import 'package:equatable/equatable.dart';

class OrderRegistration extends Equatable {
  final List<OrderEntity> products;
  final DateTime createdDate;
  final int itemCount;
  final double totalAmount;
  final String shippingAddress;
  final String orderId;

  const OrderRegistration({
    required this.products,
    required this.createdDate,
    required this.itemCount,
    required this.totalAmount,
    required this.shippingAddress,
    required this.orderId,
  });

  @override
  List<Object?> get props => [
    products,
    createdDate,
    itemCount,
    totalAmount,
    shippingAddress,
    orderId,
  ];
}
