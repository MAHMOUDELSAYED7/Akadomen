import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  static AudioPlayer? _player;
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (!_isInitialized) {
      _player = AudioPlayer();

      await _player!.setPlayerMode(PlayerMode.mediaPlayer);

      await _player!.setReleaseMode(ReleaseMode.stop);

      _isInitialized = true;
    }
  }

  static Future<void> playSound(String audioPath) async {
    try {
      await initialize();
      if (_player != null) {
        await _player!.stop();

        await _player!.play(AssetSource(audioPath));

        _player!.onPlayerComplete.listen((event) {
          log('Audio playback completed');
        });

        _player!.onPlayerStateChanged.listen((state) {
          log('Player state changed: $state');
        });
      }
    } catch (e) {
      log('Error playing sound: $e');
    }
  }

  static Future<void> dispose() async {
    if (_player != null) {
      await _player!.stop();
      await _player!.dispose();
      _player = null;
      _isInitialized = false;
    }
  }

  // Specific methods for your sounds
  static Future<void> playSplashSound() async {
    await playSound('audios/splash_sound.mp3');
  }

  static Future<void> playLogoutSound() async {
    await playSound('audios/logout_sound.mp3');
  }
}
