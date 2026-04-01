import 'package:flutter/material.dart';

import '../widgets/app_chrome.dart';
import '../widgets/fade_in_content.dart';
import '../widgets/screen_audio_wrapper.dart';
import 'emergency_services_screen.dart';
import 'home_screen.dart';

class PatientCheckScreen extends StatelessWidget {
  const PatientCheckScreen({super.key});

  static const String routeName = '/patient-check';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return ScreenAudioWrapper(
      audioAsset: 'music/CheckPatient.mp3',
      child: BrandedBackground(
        backgroundAsset: 'assets/bg.png',
        child: FadeInContent(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              children: [
                const SizedBox(height: 12),
                const ScreenHeader(
                  title: 'Check the patient for the following:',
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: const [
                        _ChecklistImage(
                          assetPath: 'assets/img/Responsiveness.png',
                        ),
                        _ChecklistImage(assetPath: 'assets/img/Breathing.png'),
                        _ChecklistImage(assetPath: 'assets/img/Pulse.png'),
                      ],
                    ),
                  ),
                ),
                NavigationButtons(
                  backLabel: 'Back',
                  nextLabel: 'Next',
                  onBack: () {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(HomeScreen.routeName);
                  },
                  onNext: () {
                    Navigator.of(
                      context,
                    ).pushNamed(EmergencyServicesScreen.routeName);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChecklistImage extends StatelessWidget {
  const _ChecklistImage({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Image.asset(
        assetPath,
        width: size.width * 0.82,
        fit: BoxFit.contain,
      ),
    );
  }
}
