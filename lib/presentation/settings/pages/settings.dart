import 'package:ecome_clean/common/widgets/appbar/app_bar.dart';
import 'package:ecome_clean/presentation/auth/bloc/sign_out_cubit.dart';
import 'package:ecome_clean/presentation/settings/widgets/my_orders_tile.dart';
import 'package:ecome_clean/presentation/settings/widgets/sign_out_button.dart';
import 'package:ecome_clean/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/my_favorties_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignOutCubit(sl()),
      child: const Scaffold(
        appBar: BasicAppbar(title: Text('Settings'), action: SignOutButton()),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [MyFavortiesTile(), SizedBox(height: 15), MyOrdersTile()],
          ),
        ),
      ),
    );
  }
}
