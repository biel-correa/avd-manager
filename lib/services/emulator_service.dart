import 'dart:io';

class EmulatorService {
  static final EmulatorService _instance = EmulatorService._internal();

  factory EmulatorService() {
    return _instance;
  }

  EmulatorService._internal();

  String _androidHome = Platform.environment['ANDROID_HOME']!;

  Future<List<String>> listAvds() async {
    var result =
        await Process.run('$_androidHome/emulator/emulator', ['-list-avds']);

    var devices = result.stdout.toString().split('\n').where((element) {
      return element.isNotEmpty;
    }).toList();

    return devices;
  }

  bool isAndroidHomeSet() {
    var result = Platform.environment['ANDROID_HOME'];

    if (result == null) {
      return false;
    }

    _androidHome = result;

    return result.isNotEmpty;
  }
}
