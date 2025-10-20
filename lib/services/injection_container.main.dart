part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //data sources
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
  sl.registerLazySingleton<CategoryDataSource>(() => CategoryDataSourceImpl());
  sl.registerLazySingleton<ProductDataSource>(() => ProductDataSourceImpl());

  //repos
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()));
  sl.registerLazySingleton<CategoryRepo>(() => CategoryRepoImpl(sl()));
  sl.registerLazySingleton<ProductRepo>(() => ProductRepoImpl(sl()));

  //use cases
  sl.registerLazySingleton<SignUpUsecase>(() => SignUpUsecase(sl()));
  sl.registerLazySingleton<GetAges>(() => GetAges(sl()));
  sl.registerLazySingleton<SignInUsecase>(() => SignInUsecase(sl()));
  sl.registerLazySingleton<ResetPassUsecase>(() => ResetPassUsecase(sl()));
  sl.registerLazySingleton<IsLoggedInUseCase>(() => IsLoggedInUseCase(sl()));
  sl.registerLazySingleton<GetUserUsecase>(() => GetUserUsecase(sl()));
  sl.registerLazySingleton<GetCategoryUsecase>(() => GetCategoryUsecase(sl()));

  sl.registerLazySingleton<GetTopSelling>(() => GetTopSelling(sl()));
  sl.registerLazySingleton<GetNewIn>(() => GetNewIn(sl()));
  sl.registerLazySingleton<GetProductsByCategoryById>(
    () => GetProductsByCategoryById(sl()),
  );

  sl.registerLazySingleton<GetProductsByTitle>(() => GetProductsByTitle(sl()));
}
