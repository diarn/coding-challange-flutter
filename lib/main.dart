import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/configs/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;

  bool isDarkMode = brightness == Brightness.dark;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
    ),
  );

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      title: 'Interview App Challenge',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff0C233D),
          onPrimary: Color(0xffF9FCFF),
          primaryContainer: Color(0xff9DCBCB),
          onPrimaryContainer: Color(0xff364343),
          secondary: Color(0xffCB6A26),
          onSecondary: Color(0xffFFE1CC),
          secondaryContainer: Color(0xffEDC752),
          onSecondaryContainer: Color(0xff675623),
          tertiary: Color(0xff449FCA),
          onTertiary: Color(0xff183847),
          tertiaryContainer: Color(0xffE9C698),
          onTertiaryContainer: Color(0xff7A674D),
          error: Color(0xffCB2626),
          onError: Color(0xffFFC6C6),
          surface: Color.fromARGB(255, 225, 225, 225),
          onSurface: Color(0xff212121),
        ),
        textTheme: GoogleFonts.nunitoSansTextTheme(),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: const Color(0xff0C233D),
        //   brightness: Brightness.dark,
        // ),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xff0C233D),
          onPrimary: Color(0xffF9FCFF),
          primaryContainer: Color(0xff89B7B7),
          onPrimaryContainer: Color(0xff364343),
          secondary: Color(0xffB75626),
          onSecondary: Color(0xffFFE1CC),
          secondaryContainer: Color(0xffD9B33E),
          onSecondaryContainer: Color(0xff675623),
          tertiary: Color(0xff308BB6),
          onTertiary: Color(0xff183847),
          tertiaryContainer: Color(0xffD5B284),
          onTertiaryContainer: Color(0xff7A674D),
          error: Color(0xffCB2626),
          onError: Color(0xffFFC6C6),
          surface: Color.fromARGB(255, 15, 15, 15),
          onSurface: Color.fromARGB(255, 193, 193, 193),
        ),
        textTheme: GoogleFonts.nunitoSansTextTheme(),
        useMaterial3: true,
      ),
      routeInformationParser: AppRoutes.goRouter.routeInformationParser,
      routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
      routerDelegate: AppRoutes.goRouter.routerDelegate,
    );
  }
}
