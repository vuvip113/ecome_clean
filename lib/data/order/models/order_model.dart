import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecome_clean/data/order/models/order_status_model.dart';
import 'package:ecome_clean/data/order/models/product_order_model.dart';
import 'package:ecome_clean/domain/order/entities/order_entity.dart';
import 'package:ecome_clean/domain/order/entities/order_status_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.code,
    required super.createdDate,
    required super.itemCount,
    required super.orderId,
    required super.orderStatus,
    required super.products,
    required super.shippingAddress,
    required super.totalAmount,
  });

  /// ✅ Parse từ Firestore document
  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return OrderModel(
      code: data['code'] ?? '',
      createdDate: parseDate(data['createdDate']),
      itemCount: data['itemCount'] ?? 0,
      orderId: data['orderId'] ?? '',
      orderStatus: (data['orderStatus'] as List<dynamic>? ?? [])
          .map((e) => OrderStatusModel.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      products: (data['products'] as List<dynamic>? ?? [])
          .map((e) => ProductOrderModel.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      shippingAddress: data['shippingAddress'] ?? '',
      totalAmount: toDouble(data['totalAmount']),
    );
  }

  /// ✅ Parse từ JSON (REST API)
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      code: map['code'] ?? '',
      createdDate: parseDate(map['createdDate']),
      itemCount: map['itemCount'] ?? 0,
      orderId: map['orderId'] ?? '',
      orderStatus: (map['orderStatus'] as List<dynamic>? ?? [])
          .map((e) => OrderStatusModel.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      products: (map['products'] as List<dynamic>? ?? [])
          .map((e) => ProductOrderModel.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      shippingAddress: map['shippingAddress'] ?? '',
      totalAmount: toDouble(map['totalAmount']),
    );
  }

  Map<String, dynamic> toJson() => toMap();

  /// ✅ Parse từ Entity (domain → data)
  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      code: entity.code,
      createdDate: entity.createdDate,
      itemCount: entity.itemCount,
      orderId: entity.orderId,
      orderStatus: entity.orderStatus
          .map((e) => OrderStatusModel.fromEntity(e))
          .toList(),
      products: entity.products
          .map((e) => ProductOrderModel.fromEntity(e))
          .toList(),
      shippingAddress: entity.shippingAddress,
      totalAmount: entity.totalAmount,
    );
  }

  /// ✅ Convert về Map để lưu Firestore hoặc gửi API
  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'createdDate': createdDate.toIso8601String(),
      'itemCount': itemCount,
      'orderId': orderId,
      'orderStatus': orderStatus
          .map((e) => (e as OrderStatusModel).toMap())
          .toList(),
      'products': products
          .map((e) => (e as ProductOrderModel).toMap())
          .toList(),
      'shippingAddress': shippingAddress,
      'totalAmount': totalAmount,
    };
  }

  /// 🧩 Helpers
  static double toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static DateTime parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }

  OrderModel copyWith({
    String? code,
    DateTime? createdDate,
    int? itemCount,
    String? orderId,
    List<OrderStatusModel>? orderStatus,
    List<ProductOrderModel>? products,
    String? shippingAddress,
    double? totalAmount,
  }) {
    return OrderModel(
      code: code ?? this.code,
      createdDate: createdDate ?? this.createdDate,
      itemCount: itemCount ?? this.itemCount,
      orderId: orderId ?? this.orderId,
      orderStatus: orderStatus ?? this.orderStatus,
      products: products ?? this.products,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      code: code,
      createdDate: createdDate,
      itemCount: itemCount,
      orderId: orderId,
      orderStatus: orderStatus
          .map((status) => (status as OrderStatusModel).toEntity())
          .toList(),
      products: products
          .map((product) => (product as ProductOrderModel).toEntity())
          .toList(),
      shippingAddress: shippingAddress,
      totalAmount: totalAmount,
    );
  }
}
