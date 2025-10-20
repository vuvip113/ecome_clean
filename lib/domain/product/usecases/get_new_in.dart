import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/product/entities/product_entity.dart';
import 'package:ecome_clean/domain/product/repo/product_repo.dart';

class GetNewIn implements UsecaseWithoutParams<List<ProductEntity>> {
  const GetNewIn(this._repo);

  final ProductRepo _repo;

  @override
  ResultFuture<List<ProductEntity>> call() async {
    return await _repo.getNewIn();
  }
}
