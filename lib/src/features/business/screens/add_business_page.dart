import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/business/services/business_service.dart';
import 'package:instock_mobile/src/features/navigation/navigation_bar.dart';
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
  BusinessService _businessService = BusinessService();
  final _formKey = GlobalKey<FormState>();
  String? _businessName;
  String? _description;
  String? _addBusinessError;

  handleAddBusiness() async {
    _addBusinessError = null;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ResponseObject response =
          await _businessService.addBusiness(_businessName!, _description!);
      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
        );
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
    }
    return const Text("");
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
      ),
    );
  }
}
