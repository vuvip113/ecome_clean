import 'package:ecome_clean/common/helper/navigator/app_navigator.dart';
import 'package:ecome_clean/presentation/auth/bloc/sign_out_cubit.dart';
import 'package:ecome_clean/presentation/auth/pages/sigin_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/configs/theme/app_colors.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignOutCubit, SignOutState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          AppNavigator.pushAndRemove(context, SiginInPage());
        } else if (state is SignOutError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: IconButton(
        onPressed: () {
          context.read<SignOutCubit>().signOut();
        },
        icon: Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            color: AppColors.secondBackground,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.logout_rounded,
            size: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
