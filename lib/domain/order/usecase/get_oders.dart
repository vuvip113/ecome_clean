import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/order/entities/order_entity.dart';
import 'package:ecome_clean/domain/order/repo/order_repo.dart';

class GetOders implements UsecaseWithoutParams<List<OrderEntity>> {
  const GetOders(this._repo);

  final OrderRepo _repo;

  @override
  ResultFuture<List<OrderEntity>> call() async {
    return _repo.getOrders();
  }
}
