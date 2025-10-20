part of 'products_display_cubit.dart';

sealed class ProductsDisplayState extends Equatable {
  const ProductsDisplayState();

  @override
  List<Object> get props => [];
}

final class ProductsDisplayInitial extends ProductsDisplayState {}

final class ProductsDisplayLoading extends ProductsDisplayState {}

final class ProductsDisplayLoaded extends ProductsDisplayState {
  final List<ProductEntity> products;

  const ProductsDisplayLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class ProductsDisplayError extends ProductsDisplayState {
  final String message;

  const ProductsDisplayError(this.message);

  @override
  List<Object> get props => [message];
}
