import 'package:ecome_clean/data/order/models/order_model.dart';
import 'package:ecome_clean/domain/order/entities/order_status_entity.dart';

class OrderStatusModel extends OrderStatusEntity {
  const OrderStatusModel({
    required super.createdDate,
    required super.done,
    required super.title,
  });

  factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
    return OrderStatusModel(
      createdDate: OrderModel.parseDate(map['createdDate']),
      done: map['done'] ?? false,
      title: map['title'] ?? '',
    );
  }

  factory OrderStatusModel.fromEntity(OrderStatusEntity entity) {
    return OrderStatusModel(
      createdDate: entity.createdDate,
      done: entity.done,
      title: entity.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdDate': createdDate.toIso8601String(),
      'done': done,
      'title': title,
    };
  }

  OrderStatusEntity toEntity() {
    return OrderStatusEntity(
      title: title,
      createdDate: createdDate,
      done: done,
    );
  }
}
