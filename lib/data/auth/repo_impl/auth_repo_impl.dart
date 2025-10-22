import 'package:dartz/dartz.dart';
import 'package:ecome_clean/core/errors/exception.dart';
import 'package:ecome_clean/core/errors/failures.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/data/auth/source/auth_data_source.dart';
import 'package:ecome_clean/domain/auth/entities/user_entity.dart';
import 'package:ecome_clean/domain/auth/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._authDataSource);
  final AuthDataSource _authDataSource;

  @override
  ResultFuture<void> signUp(UserEntity user) async {
    try {
      await _authDataSource.signUp(user);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<String>> getAges() async {
    try {
      final result = await _authDataSource.getAges();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> signIn(UserEntity user) async {
    try {
      await _authDataSource.signIn(user);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> resetPassword(String email) async {
    try {
      await _authDataSource.resetPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<bool> isLoggedIn() async {
    try {
      final result = await _authDataSource.isLoggedIn();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<UserEntity> getUser() async {
    try {
      final result = await _authDataSource.getUser();
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> signOut() async {
    try {
      await _authDataSource.signOut();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
