import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/product/entities/product_entity.dart';

abstract class ProductRepo {
  ResultFuture<List<ProductEntity>> getTopSelling();
  ResultFuture<List<ProductEntity>> getNewIn();
  ResultFuture<List<ProductEntity>> getProductsByCategoryId(String categoryId);
  ResultFuture<List<ProductEntity>> getProductsByTitle(String title);
  ResultFuture<List<ProductEntity>> addOrRemoveFavProduct(
    ProductEntity product,
  );
  ResultFuture<bool> isFav(String productId);
  ResultFuture<List<ProductEntity>> getFavoriteProducts();
}
