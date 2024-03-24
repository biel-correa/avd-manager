import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AndroidHomeNotSet extends StatelessWidget {
  final void Function()? retry;

  const AndroidHomeNotSet({super.key, required this.retry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Android Home is not set'),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _redirect, child: const Text('Learn more')),
          const SizedBox(height: 6),
          TextButton(onPressed: retry, child: const Text('Retry')),
        ],
      ),
    );
  }

  void _redirect() {
    Uri uri = Uri.https('developer.android.com', 'tools/variables');

    launchUrl(uri);
  }
}
