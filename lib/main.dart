import 'package:ecome_clean/core/configs/theme/app_theme.dart';
import 'package:ecome_clean/firebase_options.dart';
import 'package:ecome_clean/presentation/splash/bloc/splash_cubit.dart';
import 'package:ecome_clean/presentation/splash/pages/splash_screen.dart';
import 'package:ecome_clean/services/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // appStarted() chạy ngay → kiểm tra trạng thái đăng nhập.
      create: (context) => SplashCubit()..appStarted(),
      child: MaterialApp(
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    );
  }
}
