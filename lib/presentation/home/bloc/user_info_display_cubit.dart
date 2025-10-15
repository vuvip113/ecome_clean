import 'package:bloc/bloc.dart';
import 'package:ecome_clean/domain/auth/entities/user_entity.dart';
import 'package:ecome_clean/domain/auth/usecase/get_user_usecase.dart';
import 'package:equatable/equatable.dart';

part 'user_info_display_state.dart';

class UserInfoDisplayCubit extends Cubit<UserInfoDisplayState> {
  UserInfoDisplayCubit(this._getUserUsecase) : super(UserInfoDisplayInitial());
  final GetUserUsecase _getUserUsecase;

  void displayUserInfo() async {
    try {
      emit(UserInfoDisplayLoading());
      await Future.delayed(const Duration(seconds: 2));
      final user = await _getUserUsecase();
      user.fold((failure) => emit(UserInfoDisplayError(failure.message)), (
        user,
      ) {
        emit(UserInfoDisplayLoaded(user: user));
      });
    } catch (e) {
      emit(UserInfoDisplayError(e.toString()));
    }
  }
}
