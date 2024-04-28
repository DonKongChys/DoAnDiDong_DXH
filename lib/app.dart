import 'package:TShop/features/authentication/screens/onboarding/onboarding.dart';

import 'package:TShop/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const OnBoardingScreen(),
      // home: const HomeScreen(),
      // home: const SubCategoriesScreen(),
      // home: const AllProducts(),
      // home: const AllBrandsScreen(),
      // home: const StoreScreen(),

    );
  }
}
