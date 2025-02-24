import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldyu/common/screens/home/home_screnn.dart';
import 'package:goldyu/core/theme/theme.dart';
import 'package:goldyu/features/authentication/screens/onboarding/onboarding.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.dartTheme,
      home: OnboardingScreen(),
    );
  }
}
