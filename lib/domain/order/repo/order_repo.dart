import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/order/entities/order_entity.dart';
import 'package:ecome_clean/domain/order/entities/product_order_entity.dart';
abstract class OrderRepo {
  ResultFuture<void> addToCart(ProductOrderEntity order);
  ResultFuture<List<ProductOrderEntity>> getCartProducts();
  ResultFuture<void> removeFromCart(String orderId);
  ResultFuture<void> orderRegistration(OrderEntity  order);
}
