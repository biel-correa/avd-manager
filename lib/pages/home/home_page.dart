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
      body: FutureBuilder(
        future: EmulatorService().initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const ListAndroidDevices();
        },
      ),
    );
  }

  void _reportBug() {
    Uri uri = Uri.https('github.com', 'biel-correa/avd_manager/issues');

    launchUrl(uri);
  }
}
