import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/order/entities/order_entity.dart';
import 'package:ecome_clean/domain/order/repo/order_repo.dart';

class AddToCart implements UsecaseWithParams<void, OrderEntity> {
  const AddToCart(this._repo);

  final OrderRepo _repo;

  @override
  ResultFuture<void> call(OrderEntity order) async {
    return _repo.addToCart(order);
  }
}
