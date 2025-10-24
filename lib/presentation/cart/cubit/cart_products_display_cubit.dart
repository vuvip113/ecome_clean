import 'package:bloc/bloc.dart';
import 'package:ecome_clean/domain/order/entities/order_entity.dart';
import 'package:ecome_clean/domain/order/usecase/get_cart_products.dart';
import 'package:equatable/equatable.dart';

part 'cart_products_display_state.dart';

class CartProductsDisplayCubit extends Cubit<CartProductsDisplayState> {
  CartProductsDisplayCubit(this.getCartProductsUseCase)
    : super(CartProductsDisplayInitial());
  final GetCartProducts getCartProductsUseCase;

  Future<void> loadCartProducts() async {
    emit(CartProductsDisplayLoading());

    final result = await getCartProductsUseCase();

    result.fold(
      (failure) => emit(CartProductsDisplayError(failure.message)),
      (orders) => emit(CartProductsDisplayLoaded(orders)),
    );
  }
}
