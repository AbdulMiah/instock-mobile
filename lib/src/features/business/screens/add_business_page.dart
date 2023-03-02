import 'package:flutter/material.dart';
import 'package:instock_mobile/src/utilities/widgets/photo_picker.dart';

import '../../../theme/common_theme.dart';

class AddBusiness extends StatefulWidget {
  const AddBusiness({super.key});

  @override
  State<AddBusiness> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  final theme = CommonTheme();
  final _formKey = GlobalKey<FormState>();

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

              const PhotoPicker(),

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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your business name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      minLines: 1,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter the description',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your business description';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),

              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text("Continue"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.themeData.primaryColorDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}