import 'package:ecome_clean/core/utils/constants/tydefs.dart';

abstract class UsecaseWithPatams<Type, Params> {
  const UsecaseWithPatams();

  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  ResultFuture<Type> call();
}
