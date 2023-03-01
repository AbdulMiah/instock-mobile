import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme/common_theme.dart';

class AddBusiness extends StatefulWidget {
  const AddBusiness({super.key});

  @override
  State<AddBusiness> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  final theme = CommonTheme();
  final _formKey = GlobalKey<FormState>();
  final avatarSize = 150.0;
  File? image;

  // Taken from https://medium.com/unitechie/flutter-tutorial-image-picker-from-camera-gallery-c27af5490b74
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Add Business",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),

              const SizedBox(height: 40.0,),

              Container(
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
                          child: image == null
                            ? const Icon(Icons.image_not_supported_outlined, size: 80.0,)
                            : CircleAvatar(
                              radius: avatarSize/2,
                              backgroundImage: FileImage(image!),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
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
                                        },
                                        icon: const Icon(Icons.image_outlined),
                                        label: const Text("Choose from Gallery"),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: theme.themeData.primaryColorDark,
                                        ),
                                      ),

                                      const Text("or", textAlign: TextAlign.center,),

                                      ElevatedButton.icon(
                                        onPressed: () {
                                          pickImage(ImageSource.camera);
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
                    ),
                  ],
                ),
              ),

              const Divider(height: 50.0, thickness: 1.0, ),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter business name',
                      ),
                    ),
                    TextFormField(
                      minLines: 1,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter the description',
                      ),
                    ),
                    const SizedBox(height: 180.0,),
                    ElevatedButton.icon(
                      onPressed: () { },
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text("Continue"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.themeData.splashColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}