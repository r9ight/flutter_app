import 'package:flutter/material.dart';

double responsiveValue(
  BuildContext context, {
  required double ratio,
  required double min,
  required double max,
}) {
  final double width = MediaQuery.sizeOf(context).width;
  return (width * ratio).clamp(min, max).toDouble();
}

class BrandedBackground extends StatelessWidget {
  const BrandedBackground({
    super.key,
    required this.backgroundAsset,
    required this.child,
  });

  final String backgroundAsset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F2F2),
                image: DecorationImage(
                  image: AssetImage(backgroundAsset),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.88),
                      Colors.white.withValues(alpha: 0.76),
                      Colors.white.withValues(alpha: 0.16),
                      Colors.white.withValues(alpha: 0.72),
                      Colors.white.withValues(alpha: 0.92),
                    ],
                    stops: const [0, 0.24, 0.58, 0.84, 1],
                  ),
                ),
              ),
            ),
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Column(
      children: [
        Image.asset(
          'assets/logo.png',
          width: size.width * 0.38,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 340),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Alatsi',
              fontSize: responsiveValue(context, ratio: 0.05, min: 18, max: 24),
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fontScale = 1,
  });

  final String label;
  final VoidCallback onPressed;
  final double fontScale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEB1D29),
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'ADLaMDisplay',
            fontSize:
                responsiveValue(context, ratio: 0.043, min: 15, max: 18) *
                fontScale,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({
    super.key,
    required this.backLabel,
    required this.nextLabel,
    required this.onBack,
    required this.onNext,
    this.nextFontScale = 1,
  });

  final String backLabel;
  final String nextLabel;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final double nextFontScale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryActionButton(label: backLabel, onPressed: onBack),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PrimaryActionButton(
            label: nextLabel,
            onPressed: onNext,
            fontScale: nextFontScale,
          ),
        ),
      ],
    );
  }
}
