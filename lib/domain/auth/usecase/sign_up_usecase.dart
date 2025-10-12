import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/data/auth/models/register_params.dart';
import 'package:ecome_clean/domain/auth/repo/auth_repo.dart';

class SignUpUsecase implements UsecaseWithPatams<void, RegisterParams> {
  const SignUpUsecase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(RegisterParams? params) async {
    if (params == null) {
      throw ArgumentError('RegisterParams cannot be null');
    }
    // gọi tới repository
    return await _repo.signUp(params.toEntity());
  }
}
