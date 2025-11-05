part of 'orders_display_cubit.dart';

sealed class OrdersDisplayState extends Equatable {
  const OrdersDisplayState();

  @override
  List<Object> get props => [];
}

final class OrdersDisplayInitial extends OrdersDisplayState {}

final class OrdersDisplayLoading extends OrdersDisplayState {}

final class OrdersDisplayLoaded extends OrdersDisplayState {
  final List<OrderEntity> orders;

  const OrdersDisplayLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

final class OrdersDisplayError extends OrdersDisplayState {
  final String message;

  const OrdersDisplayError(this.message);

  @override
  List<Object> get props => [message];
}
