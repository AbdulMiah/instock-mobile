import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme/common_theme.dart';

class PhotoPicker extends StatefulWidget {
  PhotoPicker(
  {super.key,
  this.imageUrl,
  this.enabled = true,
  this.onImageUpdated,
  });

  String? imageUrl;
  bool enabled = true;
  final void Function(File?)? onImageUpdated;

  @override
  State<PhotoPicker> createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker> {
  final theme = CommonTheme();
  final avatarSize = 150.0;
  File? imageFile;

  // Taken from https://medium.com/unitechie/flutter-tutorial-image-picker-from-camera-gallery-c27af5490b74
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return;
      File? imageTemp = File(image.path);
      imageTemp = await cropImage(imageFile: imageTemp);
      setState(() => imageFile = imageTemp);
      widget.onImageUpdated!(imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: theme.themeData.splashColor,
        ),
      ],
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  Widget updateAvatarImage() {
    if (imageFile == null && widget.imageUrl == null) {
      return const Icon(Icons.image_not_supported_outlined, size: 80.0,);
    } else if (widget.imageUrl != null) {
      return CircleAvatar(
          radius: avatarSize/2,
          backgroundImage: NetworkImage(widget.imageUrl!)
      );
    } else {
      return CircleAvatar(
          radius: avatarSize/2,
          backgroundImage: FileImage(imageFile!)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              height: avatarSize,
              width: avatarSize,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                  border: Border.all(color: theme.themeData.primaryColorDark)
              ),
              child: Center(
                child: updateAvatarImage(),
              ),
            ),
          ),
          widget.enabled ? Positioned(
            bottom: 0.0,
            left: 90.0,
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 210,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor: theme.themeData.primaryColorLight,
                                ),
                                child: const Icon(Icons.close, color: Colors.black),
                              ),
                            ),

                            const Divider(height: 10.0, ),

                            ElevatedButton.icon(
                              onPressed: () {
                                pickImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.image_outlined),
                              label: const Text("Choose from Gallery"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.themeData.primaryColorDark,
                              ),
                            ),

                            const Text("or",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13),
                            ),

                            ElevatedButton.icon(
                              onPressed: () {
                                pickImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.camera_alt),
                              label: const Text("Take a Photo"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.themeData.primaryColorDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(5),
                backgroundColor: theme.themeData.splashColor,
                side: BorderSide(color: theme.themeData.primaryColorLight, width: 1),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 20,
              ),
            ),
          ) : const SizedBox(),
        ],
      ),
    );
  }
}
