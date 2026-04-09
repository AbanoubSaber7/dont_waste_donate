import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // أضفنا ده عشان نتحكم في ألوان النظام
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'utils/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // عشان شريط البطارية والساعة فوق يبقوا متناسقين مع الأبيض
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const ProviderScope(child: DontWasteDonateApp()));
}

class DontWasteDonateApp extends ConsumerWidget {
  const DontWasteDonateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Don\'t Waste, Donate',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // هنا الربط مع الألوان اللي هنعدلها
      routerConfig: router,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}