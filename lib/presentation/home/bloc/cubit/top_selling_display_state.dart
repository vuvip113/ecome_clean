part of 'top_selling_display_cubit.dart';

sealed class TopSellingDisplayState extends Equatable {
  const TopSellingDisplayState();

  @override
  List<Object> get props => [];
}

final class TopSellingDisplayInitial extends TopSellingDisplayState {}

final class TopSellingDisplayLoading extends TopSellingDisplayState {}

final class TopSellingDisplayLoaded extends TopSellingDisplayState {
  final List<ProductEntity> products;

  const TopSellingDisplayLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class TopSellingDisplayError extends TopSellingDisplayState {
  final String message;

  const TopSellingDisplayError(this.message);

  @override
  List<Object> get props => [message];
}
