import 'package:flutter/material.dart';

import 'data/instruction_pages.dart';
import 'navigation/app_route_observer.dart';
import 'screens/compression_screen.dart';
import 'screens/emergency_services_screen.dart';
import 'screens/home_screen.dart';
import 'screens/instruction_screen.dart';
import 'screens/patient_check_screen.dart';

class SeamlessCprApp extends StatelessWidget {
  const SeamlessCprApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seamless CPR',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [appRouteObserver],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEB1D29)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: (settings) {
        final Widget page = switch (settings.name) {
          HomeScreen.routeName => const HomeScreen(),
          PatientCheckScreen.routeName => const PatientCheckScreen(),
          EmergencyServicesScreen.routeName => const EmergencyServicesScreen(),
          CompressionScreen.routeName => const CompressionScreen(),
          _ when settings.name == handPositionPage.routeName =>
            const InstructionScreen(page: handPositionPage),
          _ when settings.name == bodyPositionPage.routeName =>
            const InstructionScreen(page: bodyPositionPage),
          _ when settings.name == compressPositionPage.routeName =>
            const InstructionScreen(page: compressPositionPage),
          _ when settings.name == breathPositionPage.routeName =>
            const InstructionScreen(page: breathPositionPage),
          _ => const HomeScreen(),
        };

        return PageRouteBuilder<void>(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 350),
          reverseTransitionDuration: const Duration(milliseconds: 250),
          pageBuilder: (context, animation, secondaryAnimation) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            );

            return FadeTransition(opacity: curvedAnimation, child: page);
          },
        );
      },
    );
  }
}
