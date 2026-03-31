import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  static const _storageKey = 'theme_mode';
  final _box = GetStorage();

  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadThemeMode();
  }

  void toggleTheme() {
    final isDark = _themeMode.value == ThemeMode.dark;
    setThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    _box.write(_storageKey, mode.name);
  }

  void _loadThemeMode() {
    final stored = _box.read<String>(_storageKey);
    if (stored == 'light') {
      _themeMode.value = ThemeMode.light;
    } else if (stored == 'dark') {
      _themeMode.value = ThemeMode.dark;
    } else {
      _themeMode.value = ThemeMode.system;
    }
  }
}
