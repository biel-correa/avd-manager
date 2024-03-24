import 'dart:io';

class EmulatorService {
  static final EmulatorService _instance = EmulatorService._internal();

  factory EmulatorService() {
    return _instance;
  }

  EmulatorService._internal();

  Future<void> listAvds() async {}

  bool isAndroidHomeSet() {
    var result = Platform.environment['ANDROID_HOME'];

    return result == null ? false : result.isNotEmpty;
  }
}
