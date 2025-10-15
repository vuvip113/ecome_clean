import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/category/entities/category.dart';

abstract class CategoryRepo {
  ResultFuture<List<Category>> getCategories();
}
