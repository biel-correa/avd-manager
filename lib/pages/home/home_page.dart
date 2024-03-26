import 'package:avd_manager/pages/home/android_home_not_set.dart';
import 'package:avd_manager/pages/home/list_android_devices.dart';
import 'package:avd_manager/services/emulator_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      appBar: AppBar(
        title: const Text('AVD Manager'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report),
            color: Colors.red,
            onPressed: _reportBug,
          ),
        ],
      ),
      body:
          false ? const ListAndroidDevices() : AndroidHomeNotSet(retry: _retry),
    );
  }

  void _retry() {
    setState(() {
      _isAndroidHomeSet = EmulatorService().isAndroidHomeSet();
    });
  }

  void _reportBug() {
    Uri uri = Uri.https('github.com', 'biel-correa/avd_manager/issues');

    launchUrl(uri);
  }
}
