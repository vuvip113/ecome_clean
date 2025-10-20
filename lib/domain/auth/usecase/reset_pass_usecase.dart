import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/auth/repo/auth_repo.dart';

class ResetPassUsecase implements UsecaseWithParams<void, String> {
  const ResetPassUsecase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String? params) async {
    if (params == null) {
      throw ArgumentError('Email cannot be null');
    }
    // gọi tới repository
    return await _repo.resetPassword(params);
  }
}
