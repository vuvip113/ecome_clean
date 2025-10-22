import 'package:ecome_clean/common/helper/navigator/app_navigator.dart';
import 'package:ecome_clean/core/configs/assets/app_images.dart';
import 'package:ecome_clean/core/configs/assets/app_vectors.dart';
import 'package:ecome_clean/core/configs/theme/app_colors.dart';
import 'package:ecome_clean/domain/auth/entities/user_entity.dart';
import 'package:ecome_clean/presentation/auth/pages/sigin_in_page.dart';
import 'package:ecome_clean/presentation/home/bloc/user_info_display_cubit.dart';
import 'package:ecome_clean/presentation/auth/bloc/sign_out_cubit.dart';
import 'package:ecome_clean/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserInfoDisplayCubit(sl())..displayUserInfo(),
        ),
        BlocProvider(create: (context) => SignOutCubit(sl())),
      ],
      child: Padding(
        padding: const EdgeInsets.only(top: 40, right: 16, left: 16),
        child: BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
          builder: (context, state) {
            if (state is UserInfoDisplayLoading) {
              return const CircularProgressIndicator();
            }
            if (state is UserInfoDisplayLoaded) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _profileImage(state.user, context),
                  _gender(state.user),
                  _card(context),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _profileImage(UserEntity user, BuildContext context) {
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
      child: GestureDetector(
        onTap: () {
          context.read<SignOutCubit>().signOut();
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: (user.image != null && user.image!.isNotEmpty)
                  ? NetworkImage(user.image!)
                  : const AssetImage(AppImages.profile) as ImageProvider,
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _gender(UserEntity user) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Text(
          user.gender == 1 ? 'Men' : 'Women',
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
    );
  }

  Widget _card(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(AppVectors.bag, fit: BoxFit.none),
      ),
    );
  }
}
