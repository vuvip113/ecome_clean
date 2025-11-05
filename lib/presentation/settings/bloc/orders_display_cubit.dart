import 'package:bloc/bloc.dart';
import 'package:ecome_clean/domain/order/entities/order_entity.dart';
import 'package:ecome_clean/domain/order/usecase/get_oders.dart';
import 'package:equatable/equatable.dart';

part 'orders_display_state.dart';

class OrdersDisplayCubit extends Cubit<OrdersDisplayState> {
  OrdersDisplayCubit(this.getOders) : super(OrdersDisplayInitial());
  final GetOders getOders;

  void loadOrders() async {
    emit(OrdersDisplayLoading());

    final returnedDate = await getOders.call();

    returnedDate.fold(
      (failure) => emit(OrdersDisplayError(failure.message)),
      (orders) => emit(OrdersDisplayLoaded(orders)),
    );
  }
}
