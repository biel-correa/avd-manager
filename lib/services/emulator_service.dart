import 'package:emulators/emulators.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:signals/signals.dart';

class EmulatorService {
  static final EmulatorService _instance = EmulatorService._internal();

  factory EmulatorService() {
    return _instance;
  }

  EmulatorService._internal();

  Signal<IList<Device>?> devices = signal(null);
  late Emulators emulators;

  Future<void> initialize() async {
    emulators = await Emulators.build();
  }

  Future<void> listAvds() async {
    var allDevices = await emulators.list();
    var runningDevices = await emulators.running();
    var devices = IList<Device>();

    for (var device in allDevices) {
      var runningDevice = runningDevices
          .where((d) => d.state.name == device.state.name)
          .firstOrNull;

      if (runningDevice != null) {
        devices = devices.add(runningDevice);
        continue;
      }

      devices = devices.add(device);
    }

    this.devices.value = devices;
  }
}
