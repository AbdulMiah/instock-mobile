import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddBusiness extends StatefulWidget {
  const AddBusiness({super.key});

  @override
  State<AddBusiness> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  final _formKey = GlobalKey<FormState>();
  final avatarSize = 140.0;
  File? image;

  // Taken from https://medium.com/unitechie/flutter-tutorial-image-picker-from-camera-gallery-c27af5490b74
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
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
                        ),
                        child: Center(
                          child: image == null
                            ? const Text("no image")
                            : CircleAvatar(
                              radius: avatarSize/2,
                              backgroundImage: FileImage(image!),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 80.0,
                      child: ElevatedButton(
                        onPressed: () {
                          pickImage();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(5),
                          backgroundColor: Colors.green,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 20,
                          color: Colors.white,
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
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter the description',
                      ),
                    ),
                    const SizedBox(height: 250.0,),
                    ElevatedButton.icon(
                      onPressed: () { },
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text("Continue"),
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