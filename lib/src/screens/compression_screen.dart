import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../widgets/app_chrome.dart';
import '../widgets/fade_in_content.dart';
import '../widgets/screen_audio_wrapper.dart';
import 'home_screen.dart';

class CompressionScreen extends StatefulWidget {
  const CompressionScreen({super.key});

  static const String routeName = '/compression';

  @override
  State<CompressionScreen> createState() => _CompressionScreenState();
}

class _CompressionScreenState extends State<CompressionScreen> {
  late final AudioPlayer _musicPlayer;
  Timer? _beatTimer;
  int _beatCount = 0;
  bool _hasStarted = false;

  @override
  void initState() {
    super.initState();
    _musicPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  }

  @override
  void dispose() {
    _beatTimer?.cancel();
    unawaited(_musicPlayer.stop());
    _musicPlayer.dispose();
    super.dispose();
  }

  Future<void> _startOrRestartBeat() async {
    await _musicPlayer.stop();
    await _musicPlayer.play(AssetSource('music/stayingalive.mp3'));

    _beatTimer?.cancel();

    if (mounted) {
      setState(() {
        _hasStarted = true;
        _beatCount = 0;
      });
    }

    _beatTimer = Timer.periodic(const Duration(milliseconds: 576), (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _beatCount = _beatCount >= 103 ? 0 : _beatCount + 1;
      });
    });
  }

  Future<void> _stopMusic() async {
    _beatTimer?.cancel();
    _beatTimer = null;
    await _musicPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return ScreenAudioWrapper(
      audioAsset: 'music/Repeat.mp3',
      child: BrandedBackground(
        backgroundAsset: 'assets/bg.png',
        child: FadeInContent(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.08,
              vertical: 12,
            ),
            child: Column(
              children: [
                const ScreenHeader(
                  title: 'Repeat until emergency services arrive',
                ),
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.asset(
                    'assets/img/Chest_compressions.gif',
                    width: 300,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 18),
                Image.asset(
                  'assets/img/music.png',
                  width: 320,
                  fit: BoxFit.contain,
                ),
                Image.asset(
                  'assets/img/warning.png',
                  width: 320,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDADCDF),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Text(
                    'BEAT NUMBER: $_beatCount/104',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'TiltWarp',
                      fontSize: responsiveValue(
                        context,
                        ratio: 0.05,
                        min: 18,
                        max: 24,
                      ),
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: _startOrRestartBeat,
                  child: Image.asset(
                    _hasStarted
                        ? 'assets/img/restart.png'
                        : 'assets/img/startmusic.png',
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 18),
                NavigationButtons(
                  backLabel: 'Back',
                  nextLabel: 'Finish',
                  onBack: () async {
                    await _stopMusic();
                    if (!context.mounted) {
                      return;
                    }
                    Navigator.of(context).pop();
                  },
                  onNext: () async {
                    await _stopMusic();
                    if (!context.mounted) {
                      return;
                    }
                    Navigator.of(
                      context,
                    ).popUntil(ModalRoute.withName(HomeScreen.routeName));
                  },
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
