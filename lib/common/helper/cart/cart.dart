import 'package:ecome_clean/domain/order/entities/order_entity.dart';

class CartHelper {
  static double calculateCartSubtotal(List<OrderEntity> products) {
    double subtotalPrice = 0;
    for (var item in products) {
      subtotalPrice = subtotalPrice + item.totalPrice;
    }
    return subtotalPrice;
  }
}
