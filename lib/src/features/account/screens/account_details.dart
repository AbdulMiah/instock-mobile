import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/account/screens/account_page.dart';
import 'package:instock_mobile/src/utilities/widgets/photo_picker.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/back_button.dart';
import '../../../utilities/widgets/instock_text_input.dart';
import '../../../utilities/widgets/wave.dart';
import '../data/user_dto.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key, required this.userDto}) : super(key: key);

  final UserDto userDto;

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return Scaffold(
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
                              "Account",
                              style: theme.themeData.textTheme.bodyMedium
                                  ?.merge(const TextStyle(fontSize: 24)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                          top: 10,
                          left: 10,
                          child: InStockBackButton(
                            page: AccountPage(),
                            colorOption: InStockBackButton.secondary,
                          )),
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        top: MediaQuery.of(context).size.height * 0.05 - 2,
                        child: const InStockWave(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PhotoPicker(
                        imageUrl: widget.userDto.imageUrl,
                        enabled: false,
                      ),
                      Padding(
                        padding: theme.textFieldPadding,
                        child: InStockTextInput(
                          enable: false,
                          text: 'First Name',
                          initialValue: widget.userDto.firstName,
                          theme: theme.themeData,
                          validators: const [],
                        ),
                      ),
                      Padding(
                        padding: theme.textFieldPadding,
                        child: InStockTextInput(
                          enable: false,
                          text: 'Last Name',
                          initialValue: widget.userDto.lastName,
                          theme: theme.themeData,
                          validators: const [],
                        ),
                      ),
                      Padding(
                        padding: theme.textFieldPadding,
                        child: InStockTextInput(
                          enable: false,
                          text: 'Email',
                          initialValue: widget.userDto.email,
                          theme: theme.themeData,
                          validators: const [],
                        ),
                      ),
                      Padding(
                        padding: theme.textFieldPadding,
                        child: InStockTextInput(
                          enable: false,
                          text: 'Password',
                          initialValue: "**********",
                          theme: theme.themeData,
                          validators: const [],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
