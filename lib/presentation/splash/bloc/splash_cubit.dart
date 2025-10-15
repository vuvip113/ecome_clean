import 'package:ecome_clean/domain/auth/usecase/is_logged_in.dart';
import 'package:ecome_clean/presentation/splash/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._isLoggedInUseCase) : super(DisplaySplash());
  final IsLoggedInUseCase _isLoggedInUseCase;

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 2));
    final result = await _isLoggedInUseCase();
    result.fold(
      (failure) => emit(UnAuthenticated()),
      (isLoggedIn) => emit(isLoggedIn ? Authenticated() : UnAuthenticated()),
    );
  }
}
