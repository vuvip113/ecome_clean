import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/auth/repo/auth_repo.dart';

/// UseCase: Đăng xuất người dùng
class SignOut implements UsecaseWithoutParams<void> {
  const SignOut(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call() async {
    return await _repo.signOut();
  }
}
