import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/category/entities/category.dart';
import 'package:ecome_clean/domain/category/repo/category_repo.dart';

class GetCategoryUsecase implements UsecaseWithoutParams<List<Category>> {
  const GetCategoryUsecase(this._repo);

  final CategoryRepo _repo;

  @override
  ResultFuture<List<Category>> call() async {
    return await _repo.getCategories();
  }
}
