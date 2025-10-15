import 'package:ecome_clean/common/helper/navigator/app_navigator.dart';
import 'package:ecome_clean/core/configs/assets/app_vectors.dart';
import 'package:ecome_clean/core/configs/theme/app_colors.dart';
import 'package:ecome_clean/presentation/auth/pages/sigin_in_page.dart';
import 'package:ecome_clean/presentation/home/pages/home_page.dart';
import 'package:ecome_clean/presentation/splash/bloc/splash_cubit.dart';
import 'package:ecome_clean/presentation/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          AppNavigator.push(context, SiginInPage());
        }
        if (state is Authenticated) {
          // Navigate to home page or main app page
          AppNavigator.push(context, const HomePage());
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(child: SvgPicture.asset(AppVectors.appLogo)),
      ),
    );
  }
}
