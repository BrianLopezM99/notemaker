import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AsyncValue<bool>>((ref) {
  return ThemeNotifier();
});

final darkModeProvider = StateProvider<bool>((ref) => false);

class ThemeNotifier extends StateNotifier<AsyncValue<bool>> {
  static const _prefKey = 'isDarkMode';

  ThemeNotifier() : super(const AsyncValue.loading()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(_prefKey) ?? false;
      state = AsyncValue.data(isDark);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final current = state.value ?? false;
    final newTheme = !current;
    await prefs.setBool(_prefKey, newTheme);
    state = AsyncValue.data(newTheme);
  }
}
