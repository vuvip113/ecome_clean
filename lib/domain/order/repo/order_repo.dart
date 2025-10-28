import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/order/entities/order_entity.dart';
import 'package:ecome_clean/domain/order/entities/order_registration.dart';

abstract class OrderRepo {
  ResultFuture<void> addToCart(OrderEntity order);
  ResultFuture<List<OrderEntity>> getCartProducts();
  ResultFuture<void> removeFromCart(String orderId);
  ResultFuture<void> orderRegistration(OrderRegistration order);
}
