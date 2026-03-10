import 'package:haggle/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  _initializeApp();
  runApp(const MyApp());
}

Future<void> _initializeApp() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init();
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

    return Routes.ONBOARDING;
  } else {
    if (isLoggedIn) {
      return Routes.ONBOARDING;
    } else {
      return Routes.ONBOARDING;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pre_Loss_Survey',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: _getInitialRoute(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade, // Optional: Add GetX transition
    );
  }
}
