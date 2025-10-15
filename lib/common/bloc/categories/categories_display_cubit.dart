import 'package:bloc/bloc.dart';
import 'package:ecome_clean/domain/category/entities/category.dart';
import 'package:ecome_clean/domain/category/usecase/get_category_usecase.dart';
import 'package:equatable/equatable.dart';

part 'categories_display_state.dart';

class CategoriesDisplayCubit extends Cubit<CategoriesDisplayState> {
  final GetCategoryUsecase _getCategoriesUseCase;

  CategoriesDisplayCubit(this._getCategoriesUseCase)
    : super(CategoriesDisplayInitial());

  void loadCategories() async {
    emit(CategoriesDisplayLoading());

    final result = await _getCategoriesUseCase();

    result.fold(
      (failure) => emit(CategoriesDisplayError(message: failure.message)),
      (categories) => emit(CategoriesDisplayLoaded(categories: categories)),
    );
  }
}
