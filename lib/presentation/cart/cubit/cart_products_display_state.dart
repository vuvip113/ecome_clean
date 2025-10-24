part of 'cart_products_display_cubit.dart';

sealed class CartProductsDisplayState extends Equatable {
  const CartProductsDisplayState();

  @override
  List<Object> get props => [];
}

final class CartProductsDisplayInitial extends CartProductsDisplayState {}

final class CartProductsDisplayLoading extends CartProductsDisplayState {}

final class CartProductsDisplayLoaded extends CartProductsDisplayState {
  final List<OrderEntity> products;

  const CartProductsDisplayLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class CartProductsDisplayError extends CartProductsDisplayState {
  final String message;

  const CartProductsDisplayError(this.message);

  @override
  List<Object> get props => [message];
}
