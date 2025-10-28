import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/order/entities/order_registration.dart';
import 'package:ecome_clean/domain/order/repo/order_repo.dart';

class OrderRegistrationUsecase
    implements UsecaseWithParams<void, OrderRegistration> {
  const OrderRegistrationUsecase(this._repo);

  final OrderRepo _repo;

  @override
  ResultFuture<void> call(OrderRegistration order) async {
    return _repo.orderRegistration(order);
  }
}
