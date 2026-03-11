import '../../core/utils/result.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> login(String username, String password);
  Future<Result<UserEntity?>> getCachedUser();
  Future<Result<void>> logout();
  Future<Result<bool>> saveTheme(bool isDark);
  Future<Result<bool>> getTheme();
}