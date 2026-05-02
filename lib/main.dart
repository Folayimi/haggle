import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:haggle/app/controllers/theme_controller.dart';
import 'package:haggle/app/routes/app_pages.dart';
import 'package:haggle/app/theme/app_theme.dart';

Future<void> main() async {
  await _initializeApp();
  runApp(const MyApp());
}

Future<void> _initializeApp() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init();
    Get.put(ThemeController(), permanent: true);
    debugPrint('App Initialized Successfully');
  } catch (e) {
    debugPrint('App not Initialized: error $e');
  }
}

String _getInitialRoute() {
  final box = GetStorage();

  // For isFirstRun: if null, it's first run
  bool isFirstRun = box.read('isFirstRun') == null  ;
  debugPrint(
    'isFirstRun check - stored value: ${box.read('isFirstRun')}, result: $isFirstRun',
  );

  // For isLoggedIn: check actual boolean value
  bool isLoggedIn = box.read('is_logged_in') == true;
  debugPrint(
    'isLoggedIn check - stored value: ${box.read('is_logged_in')}, result: $isLoggedIn',
  );

  if (isFirstRun) {
    // Mark that the app has run at least once
    box.write('isFirstRun', true);
    debugPrint('Setting isFirstRun to true');

    // Check camera permission in background
    // checkCameraPermission();

    return Routes.LOGIN;
  } else {
    if (isLoggedIn) {
      return Routes.LOGIN;
    } else {
      return Routes.LOGIN;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(
      () => GetMaterialApp(
        title: 'Haggle',
        theme: AppTheme.lightTheme(GoogleFonts.spaceGroteskTextTheme()),
        darkTheme: AppTheme.darkTheme(GoogleFonts.spaceGroteskTextTheme()),
        themeMode: themeController.themeMode,
        initialRoute: _getInitialRoute(),
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fade, // Optional: Add GetX transition
      ),
    );
  }
}
