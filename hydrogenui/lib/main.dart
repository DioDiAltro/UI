import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrogenui/screens/HomePage.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    titleBarStyle: TitleBarStyle.hidden,
    fullScreen: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final customRedTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFDC5741),
      secondary: Color(0xFF8E665E),
      surface: Color(0xFF111312),
      onPrimary: Color(0xFF522820),
      onSecondary: Color(0xFF012834),
    ),

    textTheme: GoogleFonts.kodeMonoTextTheme(),

    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF721B17), // colore pulsanti
      textTheme: ButtonTextTheme.primary,
    ),
  ).obs;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HydroGenUI',
        theme: customRedTheme.value,
        home: MyHomePage(),
      ),
    );
  }
}
