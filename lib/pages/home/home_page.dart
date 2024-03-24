import 'package:avd_manager/pages/home/android_home_not_set.dart';
import 'package:avd_manager/services/emulator_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAndroidHomeSet = false;

  @override
  void initState() {
    super.initState();

    _isAndroidHomeSet = EmulatorService().isAndroidHomeSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isAndroidHomeSet
          ? const Center(
              child: Text('Android Home is set'),
            )
          : AndroidHomeNotSet(
              retry: _retry,
            ),
    );
  }

  Future<void> _debug() async {
    await EmulatorService().listAvds();
  }

  void _retry() {
    setState(() {
      _isAndroidHomeSet = EmulatorService().isAndroidHomeSet();
    });
  }
}
