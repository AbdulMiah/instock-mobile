import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/utilities/widgets/photo_picker.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/instock_text_input.dart';
import '../../../utilities/widgets/wave.dart';

class AddBusiness extends StatefulWidget {
  const AddBusiness({super.key});

  @override
  State<AddBusiness> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  final _formKey = GlobalKey<FormState>();
  final theme = CommonTheme();
  String? _businessName;
  String? _description;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light
              .copyWith(statusBarColor: theme.themeData.splashColor),
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Container(
                      color: theme.themeData.splashColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Text(
                          "Add Business",
                          style: theme
                              .themeData.textTheme.headlineMedium
                              ?.merge(const TextStyle(fontSize: 24)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.05 - 2,
                    child: const InStockWave(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        60.0, 100.0, 60.0, 60.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const PhotoPicker(),
                        const Divider(
                          height: 50.0,
                          thickness: 1.0,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              InStockTextInput(
                                  text: 'Name',
                                  theme: theme.themeData,
                                  icon: null,
                                  validators: const [
                                    Validators.notNull,
                                    Validators.notBlank,
                                    Validators.shortLength,
                                  ],
                                  onSaved: (value) {
                                    _businessName = value;
                                  },
                              ),
                              InStockTextInput(
                                  text: 'Description',
                                  theme: theme.themeData,
                                  icon: null,
                                  maxLines: 4,
                                  validators: const [
                                    Validators.notNull,
                                    Validators.notBlank,
                                  ],
                                  onSaved: (value) {
                                    _description = value;
                                  },
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        InStockButton(
                          text: 'Continue',
                          theme: theme.themeData,
                          colorOption: InStockButton.primary,
                          icon: Icons.arrow_forward,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false
      ),
    );
  }
}
