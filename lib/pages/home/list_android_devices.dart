import 'package:avd_manager/services/emulator_service.dart';
import 'package:flutter/material.dart';

class ListAndroidDevices extends StatelessWidget {
  const ListAndroidDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: EmulatorService().listAvds(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
              child: Column(
            children: [
              const Text('An error occurred:'),
              Text(snapshot.error.toString())
            ],
          ));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No devices found'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index]),
                trailing: IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () => _startEmulator(snapshot.data![index]),
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }

  void _startEmulator(String avd) {
    EmulatorService().startEmulator(avd);
  }
}
