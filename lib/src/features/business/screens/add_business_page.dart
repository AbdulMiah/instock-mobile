import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/business/services/business_service.dart';
import 'package:instock_mobile/src/utilities/widgets/photo_picker.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/objects/response_object.dart';
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
  final theme = CommonTheme().themeData;
  String? _businessName;
  String? _description;
  String? _addBusinessError;
  String? _addBusinessSuccess;

  handleAddBusiness() async {
    _addBusinessError = null;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      BusinessService businessService = BusinessService();
      ResponseObject response =
          await businessService.addBusiness(_businessName!, _description!);
      if (response.statusCode == 201) {
        setState(() {
          _addBusinessSuccess =
              "Successfully added a business to your account.";
        });
      } else if (response.statusCode == 401) {
        setState(() {
          _addBusinessError = "Whoops something went wrong, please try again";
        });
      } else if (response.statusCode == 400) {
        setState(() {
          _addBusinessError =
              "A Business is already associated with your account.";
        });
      } else {
        setState(() {
          _addBusinessError = response.message;
        });
      }
    }
  }

  displayMessage(ThemeData theme) {
    if (_addBusinessError != null) {
      return Text(_addBusinessError!, style: theme.textTheme.headlineSmall);
    } else if (_addBusinessSuccess != null) {
      return Text(_addBusinessSuccess!, style: theme.textTheme.labelSmall);
    }
    return const Text("");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light
              .copyWith(statusBarColor: theme.splashColor),
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
                            color: theme.splashColor,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 8, 30, 0),
                              child: Text(
                                "Add Business",
                                style: theme.textTheme.bodyMedium
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
                      ],
                    ),
                  ),
                  // End of top stuff
                  Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const PhotoPicker(),
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
                                theme: theme,
                                icon: null,
                                validators: const [
                                  Validators.notNull,
                                  Validators.notBlank,
                                  Validators.shortLength,
                                  Validators.noSpecialChars
                                ],
                                onSaved: (value) {
                                  _businessName = value;
                                },
                              ),
                              InStockTextInput(
                                text: 'Description',
                                theme: theme,
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
                            ],
                          ),
                        ),
                        displayMessage(theme),
                        const SizedBox(height: 50),
                        InStockButton(
                          text: 'Continue',
                          theme: theme,
                          colorOption: InStockButton.primary,
                          icon: Icons.arrow_forward,
                          onPressed: () async {
                            handleAddBusiness();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
