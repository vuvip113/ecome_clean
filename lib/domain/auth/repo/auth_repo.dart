import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/auth/entities/user_entity.dart';

abstract class AuthRepo {
  const AuthRepo();
  ResultFuture<List<String>> getAges();
  ResultFuture<void> signUp(UserEntity user);
  ResultFuture<void> signIn(UserEntity user);
  ResultFuture<void> resetPassword(String email);
}
