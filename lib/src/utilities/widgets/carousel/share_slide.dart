import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:social_share/social_share.dart';

import '../../../theme/common_theme.dart';

class ShareSlide extends StatelessWidget {
  final String suggestionText;

  const ShareSlide({Key? key, required this.suggestionText}) : super(key: key);

  Future<String> _downloadImage(String imageUrl) async {
    var url = Uri.parse(imageUrl);
    var response = await http.get(url);
    var directory = await getTemporaryDirectory();
    String imagePath = '${directory.path}/image.jpg';
    File imageFile = await File(imagePath).create(recursive: true);
    await imageFile.writeAsBytes(response.bodyBytes);
    return imagePath;
  }

  Future<void> _deleteTemporaryImage(String imagePath) async {
    File file = File(imagePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.themeData.splashColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Text(
              suggestionText,
              textAlign: TextAlign.center,
              style: theme.themeData.textTheme.displaySmall?.merge(
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            // This is set to 2 because there is 8 padding on the button
            // and the other slides use 10 padding total
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
            child: TextButton(
              onPressed: () async {
                String imagePath = await _downloadImage(
                    "https://instock-shop-connection-icons.s3.eu-west-2.amazonaws.com/etsyLogo.jpeg");
                SocialShare.shareOptions("Hello world", imagePath: imagePath);
                _deleteTemporaryImage(imagePath);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shortcut,
                  size: 40,
                  color: theme.themeData.primaryColorLight,
                ),
              ),
            ),
          ),
          Text(
            "Tap to share",
            style: theme.themeData.textTheme.displaySmall?.merge(
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
