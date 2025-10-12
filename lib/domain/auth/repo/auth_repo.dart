import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/auth/entities/user_entity.dart';

abstract class AuthRepo {
  const AuthRepo();
  ResultFuture<void> signUp(UserEntity user);
  ResultFuture<List<String>> getAges();
}
