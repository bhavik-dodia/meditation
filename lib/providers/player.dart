import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../widgets/player/now_playing.dart';

/// Provides methos for managing the audio player.
class Player extends ChangeNotifier {
  AudioPlayer _player;
  AudioPlayer get player => _player;
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  BuildContext _context;
  set context(value) => _context = value;

  /// Starts the audio session and listens for errors.
  Future<void> initializeSession() async {
    _player = AudioPlayer();
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await _player.setAudioSource(
        AudioSource.uri(Uri.parse("asset:///assets/audio/Ezio's Family.mp3")),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  /// Closes the audio session
  void closeSession() {
    _player.pause();
    _player.dispose();
    notifyListeners();
  }

  /// Displays mini player.
  void showMiniPlayer() {
    _player.play();
    _isPlaying = true;
    showModalBottomSheet(
      isScrollControlled: true,
      context: _context,
      builder: (context) => NowPlaying(),
    );
    notifyListeners();
  }

  /// Removes mini player.
  void closeMiniPlayer() {
    _player.seek(
      Duration.zero,
      index: _player.effectiveIndices.first,
    );
    _player.pause();
    _isPlaying = false;
    notifyListeners();
  }
}
