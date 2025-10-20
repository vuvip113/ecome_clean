import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/product/usecases/get_new_in.dart';
import 'package:ecome_clean/domain/product/usecases/get_top_selling.dart';

abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  ResultFuture<Type> call();
}

class ProductUseCases {
  final GetTopSelling getTopSelling;
  final GetNewIn getNewIn;

  ProductUseCases({required this.getTopSelling, required this.getNewIn});
}
