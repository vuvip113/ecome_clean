import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/order/entities/product_order_entity.dart';
import 'package:ecome_clean/domain/order/repo/order_repo.dart';

class GetCartProducts
    implements UsecaseWithoutParams<List<ProductOrderEntity>> {
  const GetCartProducts(this._repo);

  final OrderRepo _repo;

  @override
  ResultFuture<List<ProductOrderEntity>> call() async {
    return _repo.getCartProducts();
  }
}
