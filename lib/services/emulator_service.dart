import 'dart:io';
import 'package:path/path.dart' as p;

class EmulatorService {
  static final EmulatorService _instance = EmulatorService._internal();

  factory EmulatorService() {
    return _instance;
  }

  EmulatorService._internal();

  String? _androidHome = Platform.environment['ANDROID_HOME'];
  String get _emulatorPath => p.join(_androidHome!, 'emulator', 'emulator');

  Future<List<String>> listAvds() async {
    if (_androidHome == null || _androidHome!.isEmpty) {
      throw Exception('ANDROID_HOME is not set');
    }

    var result = await Process.run(_emulatorPath, ['-list-avds']);

    var devices = result.stdout.toString().split('\n').where((element) {
      var regex = RegExp(r'^INFO\s+\|');
      if (regex.hasMatch(element)) {
        return false;
      }

      return element.isNotEmpty;
    }).toList();

    return devices;
  }

  Future<void> startEmulator(String avd) async {
    if (_androidHome == null || _androidHome!.isEmpty) {
      throw Exception('ANDROID_HOME is not set');
    }

    print('$_emulatorPath -avd $avd');
    await Process.run(_emulatorPath, ['-avd', avd]);
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
