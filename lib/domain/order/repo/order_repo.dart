import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/order/entities/order_entity.dart';

abstract class OrderRepo {
  ResultFuture<void> addToCart(OrderEntity order);
}
