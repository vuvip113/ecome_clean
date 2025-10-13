import 'package:ecome_clean/common/bloc/button/button_state.dart';
import 'package:ecome_clean/common/bloc/button/button_state_cubit.dart';
import 'package:ecome_clean/common/helper/navigator/app_navigator.dart';
import 'package:ecome_clean/common/widgets/appbar/app_bar.dart';
import 'package:ecome_clean/common/widgets/button/basic_reactive_button.dart';
import 'package:ecome_clean/data/auth/models/register_params.dart';
import 'package:ecome_clean/domain/auth/usecase/sign_in_usecase.dart';
import 'package:ecome_clean/presentation/auth/pages/forgot_password.dart';
import 'package:ecome_clean/services/injection_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterPasswordPage extends StatelessWidget {
  EnterPasswordPage({super.key, required this.params});
  final RegisterParams params;

  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: BlocProvider(
          create: (context) => ButtonStateCubit(),
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if (state is ButtonFailureState) {
                // Handle error state if needed
                var errorMessage = state.errorMessage;
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(errorMessage)));
              }
              if (state is ButtonSuccessState) {
                // Handle success state if needed
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _siginText(context),
                const SizedBox(height: 20),
                _passwordField(context),
                const SizedBox(height: 20),
                _continueButton(context),
                const SizedBox(height: 20),
                _forgotPassword(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _siginText(BuildContext context) {
    return const Text(
      'Sign in',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordCon,
      decoration: const InputDecoration(hintText: 'Enter Password'),
    );
  }

  Widget _continueButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return BasicReactiveButton(
          onPressed: () async {
            final signInUsecase = SignInUsecase(sl());
            final updatedParams = RegisterParams(
              email: params.email,
              password: _passwordCon.text,
            );
            await context.read<ButtonStateCubit>().executeUsecase(
              signInUsecase,
              updatedParams,
            );
          },
          title: 'Continue',
        );
      },
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(text: "Forgot password? "),
          TextSpan(
            text: 'Reset',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigator.push(context, ForgotPasswordPage());
              },
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
