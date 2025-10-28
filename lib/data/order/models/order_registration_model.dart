import 'package:ecome_clean/data/order/models/order_model.dart';
import 'package:ecome_clean/domain/order/entities/order_registration.dart';
import 'package:equatable/equatable.dart';

class OrderRegistrationModel extends Equatable {
  final List<OrderModel> products;
  final DateTime createdDate;
  final int itemCount;
  final double totalAmount;
  final String shippingAddress;
  final String orderId;

  const OrderRegistrationModel({
    required this.products,
    required this.createdDate,
    required this.itemCount,
    required this.totalAmount,
    required this.shippingAddress,
    required this.orderId,
  });

  /// ✅ Parse từ JSON
  factory OrderRegistrationModel.fromJson(Map<String, dynamic> json) {
    return OrderRegistrationModel(
      products: (json['products'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e))
          .toList(),
      createdDate: DateTime.parse(json['createdDate']),
      itemCount: json['itemCount'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      shippingAddress: json['shippingAddress'],
      orderId: json['orderId'],
    );
  }

  /// ✅ Chuyển sang JSON
  Map<String, dynamic> toJson() {
    return {
      'products': products.map((e) => e.toJson()).toList(),
      'createdDate': createdDate.toIso8601String(),
      'itemCount': itemCount,
      'totalAmount': totalAmount,
      'shippingAddress': shippingAddress,
      'orderId': orderId,
    };
  }

  /// ✅ Tạo bản sao có thể chỉnh sửa
  OrderRegistrationModel copyWith({
    List<OrderModel>? products,
    DateTime? createdDate,
    int? itemCount,
    double? totalAmount,
    String? shippingAddress,
    String? orderId,
  }) {
    return OrderRegistrationModel(
      products: products ?? this.products,
      createdDate: createdDate ?? this.createdDate,
      itemCount: itemCount ?? this.itemCount,
      totalAmount: totalAmount ?? this.totalAmount,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      orderId: orderId ?? this.orderId,
    );
  }

  factory OrderRegistrationModel.fromEntity(OrderRegistration entity) {
    return OrderRegistrationModel(
      products: entity.products.map((e) => OrderModel.fromEntity(e)).toList(),
      createdDate: entity.createdDate,
      itemCount: entity.itemCount,
      totalAmount: entity.totalAmount,
      shippingAddress: entity.shippingAddress,
      orderId: entity.orderId,
    );
  }

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
