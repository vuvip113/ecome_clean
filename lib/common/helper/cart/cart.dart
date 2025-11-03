import 'package:ecome_clean/domain/order/entities/product_order_entity.dart';

class CartHelper {
  static double calculateCartSubtotal(List<ProductOrderEntity> products) {
    double subtotalPrice = 0;
    for (var item in products) {
      subtotalPrice = subtotalPrice + item.totalPrice;
    }
    return subtotalPrice;
  }
}
