import 'package:audioplayers/audioplayers.dart';

class PromptAudioController {
  PromptAudioController._();

  static final PromptAudioController instance = PromptAudioController._();

  AudioPlayer? _activePlayer;
  Future<void> _pendingOperation = Future<void>.value();

  Future<void> play(String assetPath) {
    return _enqueue(() async {
      await _stopActive();

      final player = AudioPlayer();
      _activePlayer = player;

      try {
        await player.setReleaseMode(ReleaseMode.stop);
        await player.play(AssetSource(assetPath));
      } catch (_) {
        if (_activePlayer == player) {
          _activePlayer = null;
        }
        await player.dispose();
      }
    });
  }

  Future<void> stop() {
    return _enqueue(_stopActive);
  }

  Future<void> _enqueue(Future<void> Function() action) {
    final nextOperation = _pendingOperation
        .catchError((Object _) {})
        .then((_) => action());

    _pendingOperation = nextOperation.catchError((Object _) {});
    return nextOperation;
  }

  Future<void> _stopActive() async {
    final player = _activePlayer;
    _activePlayer = null;

    if (player == null) {
      return;
    }

    try {
      await player.stop();
    } catch (_) {}

    await player.dispose();
  }
}
