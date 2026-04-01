import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/instruction_pages.dart';
import '../widgets/app_chrome.dart';
import '../widgets/fade_in_content.dart';
import '../widgets/screen_audio_wrapper.dart';

class EmergencyServicesScreen extends StatefulWidget {
  const EmergencyServicesScreen({super.key});

  static const String routeName = '/emergency-services';

  @override
  State<EmergencyServicesScreen> createState() =>
      _EmergencyServicesScreenState();
}

class _EmergencyServicesScreenState extends State<EmergencyServicesScreen> {
  static const String _emergencyNumber = '0912887';

  Position? _position;
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    if (_isLoadingLocation) {
      return;
    }

    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        _showSnackBar(
          'Turn on location services to include coordinates in SMS.',
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _showSnackBar(
          'Location permission was denied. SMS will use a manual location placeholder.',
        );
        return;
      }

      final Position position = await Geolocator.getCurrentPosition();
      if (!mounted) {
        return;
      }

      setState(() {
        _position = position;
      });
    } catch (_) {
      _showSnackBar('Unable to get your current location right now.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingLocation = false;
        });
      }
    }
  }

  Future<void> _launch(Uri uri, String errorMessage) async {
    final bool launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched && mounted) {
      _showSnackBar(errorMessage);
    }
  }

  Future<void> _callEmergencyServices() {
    return _launch(
      Uri(scheme: 'tel', path: _emergencyNumber),
      'Could not open the dialer.',
    );
  }

  Future<void> _sendSms() {
    final String message = _position == null
        ? 'I am performing CPR on someone and need immediate help. I am located at [ENTER LOCATION HERE]. Please send help immediately.'
        : 'I am performing CPR on someone and need immediate help. My location is latitude ${_position!.latitude}, longitude ${_position!.longitude}. Please send help immediately.';

    return _launch(
      Uri(
        scheme: 'sms',
        path: _emergencyNumber,
        queryParameters: <String, String>{'body': message},
      ),
      'Could not open the messaging app.',
    );
  }

  void _showSnackBar(String message) {
    if (!mounted) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return ScreenAudioWrapper(
      audioAsset: 'music/Emergency.mp3',
      child: BrandedBackground(
        backgroundAsset: 'assets/bg.png',
        child: FadeInContent(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              children: [
                const SizedBox(height: 12),
                const ScreenHeader(title: 'Reach out to emergency services'),
                const SizedBox(height: 18),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ActionImageButton(
                          assetPath: 'assets/img/Call.png',
                          onTap: _callEmergencyServices,
                        ),
                        const SizedBox(height: 10),
                        _ActionImageButton(
                          assetPath: 'assets/img/Msg.png',
                          onTap: _sendSms,
                        ),
                        const SizedBox(height: 18),
                        Text(
                          _position == null
                              ? (_isLoadingLocation
                                    ? 'Fetching location for SMS...'
                                    : 'SMS will use a manual location placeholder until GPS is available.')
                              : 'Location ready for SMS sharing.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Alata',
                            fontSize: responsiveValue(
                              context,
                              ratio: 0.038,
                              min: 14,
                              max: 18,
                            ),
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                NavigationButtons(
                  backLabel: 'Back',
                  nextLabel: 'Next',
                  onBack: () {
                    Navigator.of(context).pop();
                  },
                  onNext: () {
                    Navigator.of(context).pushNamed(handPositionPage.routeName);
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

class _ActionImageButton extends StatelessWidget {
  const _ActionImageButton({required this.assetPath, required this.onTap});

  final String assetPath;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        assetPath,
        width: size.width * 0.9,
        fit: BoxFit.contain,
      ),
    );
  }
}
