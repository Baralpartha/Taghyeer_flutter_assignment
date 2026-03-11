// save_theme_usecase.dart
import '../../core/utils/result.dart';
import '../repositories/auth_repository.dart';

class SaveThemeUseCase {
  final AuthRepository repository;
  SaveThemeUseCase(this.repository);

  Future<Result<bool>> call(bool isDark) => repository.saveTheme(isDark);
}