// get_theme_usecase.dart
import '../../core/utils/result.dart';
import '../repositories/auth_repository.dart';

class GetThemeUseCase {
  final AuthRepository repository;
  GetThemeUseCase(this.repository);

  Future<Result<bool>> call() => repository.getTheme();
}