part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //data sources
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
  sl.registerLazySingleton<CategoryDataSource>(() => CategoryDataSourceImpl());

  //repos
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()));
  sl.registerLazySingleton<CategoryRepo>(() => CategoryRepoImpl(sl()));

  //use cases
  sl.registerLazySingleton<SignUpUsecase>(() => SignUpUsecase(sl()));
  sl.registerLazySingleton<GetAges>(() => GetAges(sl()));
  sl.registerLazySingleton<SignInUsecase>(() => SignInUsecase(sl()));
  sl.registerLazySingleton<ResetPassUsecase>(() => ResetPassUsecase(sl()));
  sl.registerLazySingleton<IsLoggedInUseCase>(() => IsLoggedInUseCase(sl()));
  sl.registerLazySingleton<GetUserUsecase>(() => GetUserUsecase(sl()));
  sl.registerLazySingleton<GetCategoryUsecase>(() => GetCategoryUsecase(sl()));
}
