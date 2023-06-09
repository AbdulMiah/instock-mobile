import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/business/data/AddNewBusinessDto.dart';
import 'package:instock_mobile/src/features/business/services/business_service.dart';
import 'package:instock_mobile/src/features/navigation/navigation_bar.dart';
import 'package:instock_mobile/src/utilities/widgets/photo_picker.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/objects/response_object.dart';
import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/instock_text_input.dart';
import '../../../utilities/widgets/page_route_animation.dart';
import '../../../utilities/widgets/wave.dart';

class AddBusiness extends StatefulWidget {
  const AddBusiness({super.key});

  @override
  State<AddBusiness> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  final BusinessService _businessService = BusinessService();
  final _formKey = GlobalKey<FormState>();
  String? _businessName;
  String? _description;
  File? _imageFile;
  String? _addBusinessError;

  handleAddBusiness() async {
    _addBusinessError = null;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AddNewBusinessDto newBusiness = AddNewBusinessDto(
        name: _businessName!,
        description: _description!,
        imageFile: _imageFile
      );
      ResponseObject response = await _businessService.addBusiness(newBusiness);

      if (response.requestSuccess!) {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteAnimation(page: const NavBar()),
          (route) => false,
        );
      } else if (response.hasErrors()) {
        setState(() {
          //only displays first error so user is not overwhelmed
          _addBusinessError = response.errors![0];
        });
      } else {
        setState(() {
          _addBusinessError =
              "Something went wrong, please check your connection and try again";
        });
      }
    }
  }

  displayMessage(ThemeData theme) {
    if (_addBusinessError != null) {
      return Text(_addBusinessError!, style: theme.textTheme.headlineSmall);
    }
    return const Text("");
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: theme.themeData.splashColor),
        child: SingleChildScrollView(
          child: SafeArea(
              child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
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
                            padding: const EdgeInsets.fromLTRB(30, 8, 30, 0),
                            child: Text(
                              "Add Business",
                              style: theme.themeData.textTheme.bodyMedium
                                  ?.merge(const TextStyle(fontSize: 24)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        top: MediaQuery.of(context).size.height * 0.05 - 2,
                        child: const InStockWave(),
                      ),
                    ],
                  ),
                ),
                // End of top stuff
                Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PhotoPicker(
                        onImageUpdated: (file) {
                          setState(() => _imageFile = file);
                        },
                      ),
                      const Divider(
                        height: 50.0,
                        thickness: 1.0,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InStockTextInput(
                              text: 'Name',
                              theme: theme.themeData,
                              icon: null,
                              validators: const [
                                Validators.notNull,
                                Validators.notBlank,
                                Validators.shortLength,
                                Validators.nameValidation,
                              ],
                              onSaved: (value) {
                                _businessName = value;
                              },
                            ),
                            Padding(
                              padding: theme.textFieldPadding,
                              child: InStockTextInput(
                                text: 'Description',
                                theme: theme.themeData,
                                icon: null,
                                maxLines: 4,
                                validators: const [
                                  Validators.notNull,
                                  Validators.notBlank,
                                  Validators.longLength
                                ],
                                onSaved: (value) {
                                  _description = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      InStockButton(
                        text: 'Continue',
                        theme: theme.themeData,
                        colorOption: InStockButton.primary,
                        icon: Icons.arrow_forward,
                        onPressed: () async {
                          handleAddBusiness();
                        },
                      ),
                      displayMessage(theme.themeData),
                    ],
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
