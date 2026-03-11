import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/local_storage_data_source.dart';
import '../../data/datasources/posts_remote_data_source.dart';
import '../../data/datasources/products_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/post_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_cached_user_usecase.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/get_theme_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/save_theme_usecase.dart';
import '../../presentation/cubits/auth/auth_cubit.dart';
import '../../presentation/cubits/posts/posts_cubit.dart';
import '../../presentation/cubits/products/products_cubit.dart';
import '../../presentation/cubits/theme/theme_cubit.dart';
import '../network/dio_client.dart';

final sl = GetIt.instance;

Future<void> setupInjection(SharedPreferences prefs) async {
  sl.registerLazySingleton(() => prefs);

  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton(() => LocalStorageDataSource(sl()));
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl()));
  sl.registerLazySingleton(() => ProductsRemoteDataSource(sl()));
  sl.registerLazySingleton(() => PostsRemoteDataSource(sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(sl()));
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(sl()));

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedUserUseCase(sl()));
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetPostsUseCase(sl()));
  sl.registerLazySingleton(() => SaveThemeUseCase(sl()));
  sl.registerLazySingleton(() => GetThemeUseCase(sl()));

  sl.registerFactory(() => AuthCubit(sl(), sl(), sl()));
  sl.registerFactory(() => ProductsCubit(sl()));
  sl.registerFactory(() => PostsCubit(sl()));
  sl.registerFactory(() => ThemeCubit(sl(), sl()));
}