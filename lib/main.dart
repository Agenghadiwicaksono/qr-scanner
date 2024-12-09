import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart'; // Tambahkan DevicePreview
import 'package:qr_scanner_code/ui/home_screen.dart';
import 'package:qr_scanner_code/ui/qr_generator_scanner.dart';
import 'package:qr_scanner_code/ui/qr_scanner_screen.dart';
import 'package:qr_scanner_code/ui/splash_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Aktifkan DevicePreview jika bukan release mode
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true, // Gunakan media query dari DevicePreview
      locale: DevicePreview.locale(context), // Sesuaikan locale dengan DevicePreview
      builder: DevicePreview.appBuilder, // Builder untuk DevicePreview
      theme: ThemeData(
        fontFamily: 'Manrope',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(), // Tema gelap jika diperlukan
      initialRoute: '/', // Rute awal
      routes: {
        '/': (context) => const SplashScreen(), // SplashScreen sebagai rute awal
        '/home': (context) => const HomeScreen(),
        '/create': (context) => const QrScannerScreen(),
        '/scan': (context) => const QrGeneratorScanner(),
      },
    );
  }
}
