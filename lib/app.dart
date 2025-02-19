import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/core/theme/theme.dart';
import 'package:goldyu/features/authentication/screens/onboarding.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.dartTheme,
      home: const OnboardingScreen(),
    );
  }
}
