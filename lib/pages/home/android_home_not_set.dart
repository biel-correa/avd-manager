import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AndroidHomeNotSet extends StatelessWidget {
  const AndroidHomeNotSet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Android Home is not set'),
          const SizedBox(height: 16),
          TextButton(onPressed: _redirect, child: const Text('Learn more'))
        ],
      ),
    );
  }

  void _redirect() {
    Uri uri = Uri.https('developer.android.com', 'tools/variables');

    launchUrl(uri);
  }
}
