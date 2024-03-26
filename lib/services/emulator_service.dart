import 'dart:io';
import 'package:avd_manager/models/device.dart';
import 'package:path/path.dart' as p;
import 'package:signals/signals.dart';

class EmulatorService {
  static final EmulatorService _instance = EmulatorService._internal();

  factory EmulatorService() {
    return _instance;
  }

  EmulatorService._internal();

  String? _androidHome = Platform.environment['ANDROID_HOME'];
  String get _emulatorPath => p.join(_androidHome!, 'emulator', 'emulator');
  Signal<List<Device>?> devices = signal(null);

  Future<void> listAvds() async {
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

    this.devices.set(devices.map((e) => Device(name: e)).toList());
  }

  Future<void> startEmulator(Device device) async {
    if (_androidHome == null || _androidHome!.isEmpty) {
      throw Exception('ANDROID_HOME is not set');
    }

    try {
      var result = await Process.start(_emulatorPath, ['-avd', device.name]);

      device.processId = result.pid;

      var devices = this.devices.value;

      if (devices == null) {
        throw Exception('No devices found');
      }

      for (var element in devices) {
        if (element.name == device.name) {
          element.processId = device.processId;
        }
      }

      this.devices.set(devices);
    } catch (e) {
      throw Exception('Failed to start emulator');
    }
  }

  stopEmulator(Device device) {
    if (device.processId == null) {
      throw Exception('Emulator is not running');
    }

    Process.killPid(device.processId!);

    var devices = this.devices.value;

    if (devices == null) {
      throw Exception('No devices found');
    }

    for (var element in devices) {
      if (element.name == device.name) {
        element.processId = null;
      }
    }

    this.devices.set(devices);
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
