part of 'sign_out_cubit.dart';

abstract class SignOutState {}

class SignOutInitial extends SignOutState {}

class SignOutLoading extends SignOutState {}

class SignOutSuccess extends SignOutState {}

class SignOutError extends SignOutState {
  final String message;
  SignOutError(this.message);
}
