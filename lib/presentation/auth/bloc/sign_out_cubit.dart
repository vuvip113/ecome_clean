import 'package:ecome_clean/domain/auth/usecase/sign_out.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit(this._signOut) : super(SignOutInitial());

  final SignOut _signOut;

  Future<void> signOut() async {
    emit(SignOutLoading());
    final result = await _signOut();

    result.fold(
      (failure) => emit(SignOutError(failure.errorMessage)),
      (_) => emit(SignOutSuccess()),
    );
  }
}
