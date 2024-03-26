import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AndroidHomeNotSet extends StatelessWidget {
  final void Function()? retry;

  const AndroidHomeNotSet({super.key, required this.retry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ANDROID_HOME is not set',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 6),
            const Text(
              'ANDROID_HOME is an environment variable that points to the Android SDK folder. It is required to run AVD Manager.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _redirect,
                  child: const Text('Learn more'),
                ),
                const SizedBox(width: 6),
                TextButton(
                  onPressed: retry,
                  child: const Text('Retry'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _redirect() {
    Uri uri = Uri.https('developer.android.com', 'tools/variables');

    launchUrl(uri);
  }
}
