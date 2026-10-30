import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: PlotTheirFutureApp(),
    ),
  );
}

class PlotTheirFutureApp extends StatelessWidget {
  const PlotTheirFutureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plot Their Future • Wedding Gift Registry',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.festiveLightTheme,
      home: const HomeScreen(),
    );
  }
}
