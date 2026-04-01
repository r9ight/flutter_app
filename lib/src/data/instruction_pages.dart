class InstructionPageData {
  const InstructionPageData({
    required this.routeName,
    required this.audioAsset,
    required this.imageAsset,
    required this.indicatorAsset,
    required this.headline,
    required this.description,
    required this.nextRouteName,
    this.nextLabel = 'Next',
  });

  final String routeName;
  final String audioAsset;
  final String imageAsset;
  final String indicatorAsset;
  final String headline;
  final String description;
  final String nextRouteName;
  final String nextLabel;
}

const InstructionPageData handPositionPage = InstructionPageData(
  routeName: '/hand-position',
  audioAsset: 'music/HandPosition.mp3',
  imageAsset: 'assets/img/handpos.png',
  indicatorAsset: 'assets/img/pg1.png',
  headline: 'HAND POSITION',
  description:
      'Two hands centered on the chest. Do not leave space between the chest and hands. Make sure the fingers are interlaced.',
  nextRouteName: '/body-position',
);

const InstructionPageData bodyPositionPage = InstructionPageData(
  routeName: '/body-position',
  audioAsset: 'music/BodyPosition.mp3',
  imageAsset: 'assets/img/bodypos.png',
  indicatorAsset: 'assets/img/pg2.png',
  headline: 'BODY POSITION',
  description:
      'Keep shoulders directly over the hands and elbows locked. Make sure the hands stay at a 90-degree angle to the body.',
  nextRouteName: '/compress-position',
);

const InstructionPageData compressPositionPage = InstructionPageData(
  routeName: '/compress-position',
  audioAsset: 'music/CompressPosition.mp3',
  imageAsset: 'assets/img/compresspos.png',
  indicatorAsset: 'assets/img/pg3.png',
  headline: 'COMPRESS DEEP, LIFT, AND STAY ON BEAT',
  description:
      'Compress at least 2 inches deep and lift fully between compressions. Do 30 compressions on beat, give two breaths, then repeat.',
  nextRouteName: '/breath-position',
);

const InstructionPageData breathPositionPage = InstructionPageData(
  routeName: '/breath-position',
  audioAsset: 'music/BreathPosition.mp3',
  imageAsset: 'assets/img/breathpos.png',
  indicatorAsset: 'assets/img/pg4.png',
  headline: 'GIVE TWO BREATHS EVERY 30 COMPRESSIONS',
  description:
      "Pinch the patient's nose, tilt the head, and give two breaths. Do this every 30 compressions.",
  nextRouteName: '/compression',
  nextLabel: 'Ready to Start?',
);
