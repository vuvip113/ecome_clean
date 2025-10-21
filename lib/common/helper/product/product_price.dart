import 'package:ecome_clean/domain/product/entities/product_entity.dart';

class ProductPriceHelper {
  static double provideCurrencyPrice(ProductEntity product) {
    return product.discountedPrice != 0
        ? product.discountedPrice
        : product.price;
  }
}
