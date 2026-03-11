// theme_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_theme_usecase.dart';
import '../../../domain/usecases/save_theme_usecase.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SaveThemeUseCase saveThemeUseCase;
  final GetThemeUseCase getThemeUseCase;

  ThemeCubit(this.saveThemeUseCase, this.getThemeUseCase) : super(ThemeMode.light);

  Future<void> loadTheme() async {
    final result = await getThemeUseCase();
    emit((result.data ?? false) ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleTheme(bool isDark) async {
    await saveThemeUseCase(isDark);
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}