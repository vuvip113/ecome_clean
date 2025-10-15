import 'package:bloc/bloc.dart';
import 'package:ecome_clean/domain/product/entities/product_entity.dart';
import 'package:ecome_clean/domain/product/usecases/get_top_selling.dart';
import 'package:equatable/equatable.dart';

part 'top_selling_display_state.dart';

class TopSellingDisplayCubit extends Cubit<TopSellingDisplayState> {
  TopSellingDisplayCubit(this._getTopSelling)
    : super(TopSellingDisplayInitial());
  final GetTopSelling _getTopSelling;
  void displayTopSelling() async {
    try {
      emit(TopSellingDisplayLoading());
      await Future.delayed(const Duration(seconds: 2));
      final result = await _getTopSelling();
      result.fold(
        (failure) => emit(TopSellingDisplayError(failure.message)),
        (products) => emit(TopSellingDisplayLoaded(products)),
      );
    } catch (e) {
      emit(TopSellingDisplayError(e.toString()));
    }
  }
}
