import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/order/repo/order_repo.dart';

class RemoveFromCart implements UsecaseWithParams<void, String> {
  const RemoveFromCart(this._repo);

  final OrderRepo _repo;

  @override
  ResultFuture<void> call(String orderId) async {
    return _repo.removeFromCart(orderId);
  }
}
