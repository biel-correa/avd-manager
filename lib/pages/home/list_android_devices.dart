import 'package:avd_manager/services/emulator_service.dart';
import 'package:emulators/emulators.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class ListAndroidDevices extends StatefulWidget {
  const ListAndroidDevices({super.key});

  @override
  State<ListAndroidDevices> createState() => _ListAndroidDevicesState();
}

class _ListAndroidDevicesState extends State<ListAndroidDevices> {
  @override
  void initState() {
    super.initState();

    EmulatorService().listAvds();
  }

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) {
        var devices = EmulatorService().devices.value;

        if (devices == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (devices.isEmpty) {
          return const Center(
            child: Text('No devices found'),
          );
        }

        return ListView.builder(
          itemCount: devices.length,
          itemBuilder: (context, index) {
            var device = devices[index];
            return ListTile(
              title: Text(device.state.name),
              trailing: device.state.booted
                  ? IconButton(
                      icon: const Icon(Icons.stop, color: Colors.red),
                      onPressed: () => _stopEmulator(device),
                    )
                  : IconButton(
                      icon: const Icon(Icons.play_arrow, color: Colors.green),
                      onPressed: () => _startEmulator(device),
                    ),
            );
          },
        );
      },
    );
  }

  Future<void> _startEmulator(Device device) async {
    await device.boot();

    setState(() {});
  }

  Future<void> _stopEmulator(Device device) async {
    await device.shutdown();

    setState(() {});
  }
}
