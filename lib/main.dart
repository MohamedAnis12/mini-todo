import 'package:flutter/material.dart';
import 'package:minitodo/views/splash_view/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashView(),
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xfff7f9fd)),
      debugShowCheckedModeBanner: false,
    );
  }
}
