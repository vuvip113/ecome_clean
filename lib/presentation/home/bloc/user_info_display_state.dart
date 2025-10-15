part of 'user_info_display_cubit.dart';

abstract class UserInfoDisplayState extends Equatable {
  const UserInfoDisplayState();

  @override
  List<Object> get props => [];
}

class UserInfoDisplayInitial extends UserInfoDisplayState {}

class UserInfoDisplayLoading extends UserInfoDisplayState {}

class UserInfoDisplayLoaded extends UserInfoDisplayState {
  final UserEntity user;
  const UserInfoDisplayLoaded({required this.user});
}

class UserInfoDisplayError extends UserInfoDisplayState {
  final String message;

  const UserInfoDisplayError(this.message);

  @override
  List<Object> get props => [message];
}
