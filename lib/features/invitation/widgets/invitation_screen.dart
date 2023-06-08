import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wedding_s_w/shared/resources/images.dart';

class InvitationScreen extends StatelessWidget {
  const InvitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(imageProvider: Images.invitation),
      floatingActionButton: FloatingActionButton(
        onPressed: shareInvitation,
        child: const Icon(Icons.share),
      ),
    );
  }

  Future<void> shareInvitation() async {
    final data = await rootBundle.load(Images.invitationPath);
    final _ = await Share.shareXFiles(
      [
        XFile.fromData(
          data.buffer.asUint8List(),
          mimeType: 'image/png',
        ),
      ],
      text: 'Uitnodiging trouw Sara & Wim',
    );
  }
}
