import 'package:dartz/dartz.dart';
import 'package:ecome_clean/core/errors/exception.dart';
import 'package:ecome_clean/core/errors/failures.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/data/category/source/category_data_source.dart';
import 'package:ecome_clean/domain/category/entities/category.dart';
import 'package:ecome_clean/domain/category/repo/category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  const CategoryRepoImpl(this._categoryDataSource);
  final CategoryDataSource _categoryDataSource;

  @override
  ResultFuture<List<Category>> getCategories()async {
    try {
      final result = await _categoryDataSource.getCategories();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
