part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //data sources
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());

  //repos
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()));

  //use cases
  sl.registerLazySingleton<SignUpUsecase>(() => SignUpUsecase(sl()));
  sl.registerLazySingleton<GetAges>(() => GetAges(sl()));
  sl.registerLazySingleton<SignInUsecase>(() => SignInUsecase(sl()));
  sl.registerLazySingleton<ResetPassUsecase>(() => ResetPassUsecase(sl()));
}
