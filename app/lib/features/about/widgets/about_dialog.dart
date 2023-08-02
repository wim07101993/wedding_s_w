import 'package:flutter/material.dart';
import 'package:shared/resources/images.dart';
import 'package:url_launcher/url_launcher.dart';

void showAppAboutDialog(BuildContext context) {
  showAboutDialog(
    context: context,
    applicationIcon: const Image(image: Images.logo, width: 50),
    children: [
      const Text(
        "Dit is de app gemaakt voor onze trouw. Stuur zeker een paar foto's naar het gastenboek en vraag op het feest jouw favoriete liedjes aan.",
      ),
      const SizedBox(height: 12),
      const Text('Sara & Wim'),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () => launchUrl(
            Uri.parse(
              'https://github.com/wim07101993/wedding_s_w/blob/main/app/android/google_play/privacy_statement.md',
            ),
          ),
          child: const Text('Privacy policy'),
        ),
      ),
    ],
  );
}
