import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/account/account_page.dart';
import 'package:instock_mobile/src/features/inventory/services/inventory_service.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/back_button.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/instock_text_input.dart';
import '../../../utilities/widgets/wave.dart';
import '../../authentication/services/authentication_service.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final InventoryService _inventoryService =
  InventoryService(AuthenticationService());

  final TextEditingController _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _topic;
  String? _message;
  String? _error;

  handleAddItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("sending email");
    }
  }

  displayMessage(ThemeData theme) {
    if (_error != null) {
      return Text(_error!, style: theme.textTheme.headlineSmall);
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
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Text(
                                  "Contact Us",
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
                          Positioned(
                              top: 10,
                              left: 10,
                              child: InStockBackButton(
                                page: AccountPage(),
                                colorOption: InStockBackButton.secondary,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(60.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have any questions or feedback?",
                            style: theme.themeData.textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: theme.textFieldPadding,
                                  child: InStockTextInput(
                                    text: 'Topic',
                                    theme: theme.themeData,
                                    validators: const [
                                      Validators.notNull,
                                      Validators.notBlank,
                                      Validators.shortLength,
                                      Validators.nameValidation
                                    ],
                                    onSaved: (value) {
                                      _topic = value;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: theme.textFieldPadding,
                                  child: InStockTextInput(
                                    text: 'Message',
                                    maxLines: 7,
                                    theme: theme.themeData,
                                    validators: const [
                                      Validators.notNull,
                                      Validators.notBlank,
                                      Validators.longLength
                                    ],
                                    onSaved: (value) {
                                      _message = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: theme.textFieldPadding,
                            child: InStockButton(
                              text: 'Send',
                              icon: Icons.send,
                              theme: theme.themeData,
                              colorOption: InStockButton.accent,
                              onPressed: () async {
                                handleAddItem();
                              },
                            ),
                          ),
                          displayMessage(theme.themeData),
                        ],
                      ),
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
