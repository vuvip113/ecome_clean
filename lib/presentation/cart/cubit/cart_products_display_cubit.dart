import 'package:bloc/bloc.dart';
import 'package:ecome_clean/domain/order/entities/order_entity.dart';
import 'package:ecome_clean/domain/order/usecase/get_cart_products.dart';
import 'package:ecome_clean/domain/order/usecase/remove_from_cart.dart';
import 'package:ecome_clean/services/injection_container.dart';
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

  Future<void> removeProduct(OrderEntity orderEntity) async {
    emit(CartProductsDisplayLoading());
    final result = await sl<RemoveFromCart>().call(orderEntity.cartItemId!);
    result.fold(
      (failure) => emit(CartProductsDisplayError(failure.message)),
      (_) => loadCartProducts(),
    );
  }
}
