import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/auth/repo/auth_repo.dart';

class IsLoggedInUseCase implements UsecaseWithoutParams<bool> {
  const IsLoggedInUseCase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<bool> call() async {
    return await _repo.isLoggedIn();
  }
}
