import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const String kGuessSpKey = 'guess-config';
const String kMuYuSpKey = 'muyu-config';
const String kWhiteBoardSpKey = 'whiteboard-config';

class SpStorage {
  SpStorage._();

  static SpStorage? _storage;

  static SpStorage get instance {
    _storage = _storage ?? SpStorage._();
    return _storage!;
  }

  SharedPreferences? _sp;

  Future<void> initSpWhenNull() async {
    if (_sp != null) return;
    _sp = _sp ?? await SharedPreferences.getInstance();
  }

  Future<bool> saveGuess({
    required bool guessing,
    required int value,
  }) async {
    await initSpWhenNull();
    String content = json.encode({'guessing': guessing, 'value': value});
    return _sp!.setString(kGuessSpKey, content);
  }

  Future<Map<String, dynamic>> readGuessConfig() async {
    await initSpWhenNull();
    String content = _sp?.getString(kGuessSpKey) ?? "{}";
    return json.decode(content);
  }

  Future<bool> saveMuYuConfig({
    required int counter,
    required int activeImageIndex,
    required int activeAudioIndex,
  }) async {
    await initSpWhenNull();
    String content = json.encode({
      'counter': counter,
      'activeImageIndex': activeImageIndex,
      'activeAudioIndex': activeAudioIndex,
    });
    return _sp!.setString(kMuYuSpKey, content);
  }

  Future<Map<String, dynamic>> readMuYuConfig() async {
    await initSpWhenNull();
    String content = _sp?.getString(kMuYuSpKey) ?? "{}";
    return json.decode(content);
  }

  Future<bool> saveWhiteBoardConfig({
    required int activeColorIndex,
    required int activeStrokeWidthIndex,
  }) async {
    await initSpWhenNull();
    String content = json.encode({
      'activeColorIndex': activeColorIndex,
      'activeStrokeWidthIndex': activeStrokeWidthIndex,
    });
    return _sp!.setString(kWhiteBoardSpKey, content);
  }

  Future<Map<String, dynamic>> readWhiteBoardConfig() async {
    await initSpWhenNull();
    String content = _sp?.getString(kWhiteBoardSpKey) ?? "{}";
    return json.decode(content);
    // return config;
  }
}
