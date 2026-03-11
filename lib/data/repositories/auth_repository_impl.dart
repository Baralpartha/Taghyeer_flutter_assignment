// auth_repository_impl.dart
import '../../core/utils/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/local_storage_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final LocalStorageDataSource local;

  AuthRepositoryImpl(this.remote, this.local);

  @override
  Future<Result<UserEntity?>> getCachedUser() async {
    try {
      return Result.success(local.getUser());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<UserEntity>> login(String username, String password) async {
    try {
      final user = await remote.login(username, password);
      await local.saveUser(user);
      return Result.success(user);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await local.clearUser();
      return const Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<bool>> saveTheme(bool isDark) async {
    try {
      final res = await local.saveTheme(isDark);
      return Result.success(res);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<bool>> getTheme() async {
    try {
      return Result.success(local.getTheme());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}