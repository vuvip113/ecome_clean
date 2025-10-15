import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/auth/entities/user_entity.dart';
import 'package:ecome_clean/domain/auth/repo/auth_repo.dart';

class GetUserUsecase implements UsecaseWithoutParams<UserEntity> {
  const GetUserUsecase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<UserEntity> call() async {
    return await _repo.getUser();
  }
}
