import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../widgets/app_chrome.dart';
import '../widgets/fade_in_content.dart';
import '../widgets/screen_audio_wrapper.dart';
import 'patient_check_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double contentWidth = math.min(size.width * 0.82, 420);
    final double heroHeight = math.min(size.height * 0.58, 560);

    return ScreenAudioWrapper(
      audioAsset: 'music/Intro.mp3',
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/bg.png', fit: BoxFit.cover),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/picture.png',
                    height: heroHeight,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.86),
                      Colors.white.withValues(alpha: 0.74),
                      Colors.white.withValues(alpha: 0.08),
                      Colors.white.withValues(alpha: 0.72),
                      Colors.white.withValues(alpha: 0.95),
                    ],
                    stops: const [0, 0.24, 0.6, 0.84, 1],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: FadeInContent(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height * 0.015),
                          const SizedBox(height: 6),
                          Image.asset(
                            'assets/logo.png',
                            width: math.min(contentWidth * 0.5, 330),
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'INSTRUCTIONS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Alatsi',
                              letterSpacing: 1.8,
                              fontSize: responsiveValue(
                                context,
                                ratio: 0.068,
                                min: 24,
                                max: 34,
                              ),
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 26),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 280),
                            child: Text(
                              'Quick instructions to save lives.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Alata',
                                fontSize: responsiveValue(
                                  context,
                                  ratio: 0.05,
                                  min: 18,
                                  max: 24,
                                ),
                                height: 1.15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: PrimaryActionButton(
                              label: 'Save Lives',
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(PatientCheckScreen.routeName);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
