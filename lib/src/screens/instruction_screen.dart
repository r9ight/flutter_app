import 'package:flutter/material.dart';

import '../data/instruction_pages.dart';
import '../screens/compression_screen.dart';
import '../widgets/app_chrome.dart';
import '../widgets/fade_in_content.dart';
import '../widgets/screen_audio_wrapper.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key, required this.page});

  final InstructionPageData page;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return ScreenAudioWrapper(
      audioAsset: page.audioAsset,
      child: BrandedBackground(
        backgroundAsset: 'assets/bg.png',
        child: FadeInContent(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              children: [
                const SizedBox(height: 12),
                const ScreenHeader(title: 'Take into account proper position'),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: [
                        Image.asset(
                          page.imageAsset,
                          width: size.width * 0.9,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          page.headline,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'TiltWarp',
                            fontSize: responsiveValue(
                              context,
                              ratio: 0.052,
                              min: 18,
                              max: 26,
                            ),
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Alata',
                            fontSize: responsiveValue(
                              context,
                              ratio: 0.041,
                              min: 15,
                              max: 19,
                            ),
                            color: Colors.black87,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Image.asset(
                  page.indicatorAsset,
                  width: size.width * 0.16,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                NavigationButtons(
                  backLabel: 'Back',
                  nextLabel: page.nextLabel,
                  nextFontScale:
                      page.nextRouteName == CompressionScreen.routeName
                      ? 0.88
                      : 1,
                  onBack: () {
                    Navigator.of(context).pop();
                  },
                  onNext: () {
                    Navigator.of(context).pushNamed(page.nextRouteName);
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
