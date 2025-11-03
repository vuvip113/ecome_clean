import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/product/repo/product_repo.dart';

class IsFavoriteUseCase implements UsecaseWithParams<bool, String> {
  const IsFavoriteUseCase(this._repo);

  final ProductRepo _repo;
  @override
  ResultFuture<bool> call(String productId) async {
    return await _repo.isFav(productId);
  }
}
