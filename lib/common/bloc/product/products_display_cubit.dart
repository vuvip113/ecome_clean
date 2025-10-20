import 'package:bloc/bloc.dart';
import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/domain/product/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

part 'products_display_state.dart';

class ProductsDisplayCubit extends Cubit<ProductsDisplayState> {
  final dynamic usecase;

  ProductsDisplayCubit(this.usecase) : super(ProductsDisplayInitial());

  Future<void> displayProducts({String? params}) async {
    try {
      emit(ProductsDisplayLoading());

      final result = (usecase is UsecaseWithParams)
          ? await (usecase as UsecaseWithParams).call(params)
          : await (usecase as UsecaseWithoutParams).call();

      result.fold(
        (failure) => emit(ProductsDisplayError(failure.message)),
        (products) => emit(ProductsDisplayLoaded(products)),
      );
    } catch (e) {
      emit(ProductsDisplayError(e.toString()));
    }
  }

  Future<void> displayInitial() async {
    try {
      emit(ProductsDisplayInitial());
    } catch (e) {
      emit(ProductsDisplayError(e.toString()));
    }
  }
}
