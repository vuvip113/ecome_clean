import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/product/entities/product_entity.dart';

abstract class ProductRepo {
  ResultFuture<List<ProductEntity>> getTopSelling();
}
