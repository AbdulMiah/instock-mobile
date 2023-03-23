import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/authentication/services/authentication_service.dart';
import 'package:instock_mobile/src/utilities/objects/response_object.dart';

import '../../theme/common_theme.dart';
import '../../utilities/widgets/instock_button.dart';
import '../../utilities/widgets/wave.dart';
import '../auth_check.dart';
import '../authentication/services/interfaces/Iauthentication_service.dart';

class AccountPage extends StatefulWidget {
  AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  IAuthenticationService _authenticationService = AuthenticationService();
  String _content = "";

  logOut() async {
    ResponseObject response = await _authenticationService.logOut();
    if (response.requestSuccess!) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AuthCheck()),
        (route) => false,
      );
      //  I would literally never expect this to happen
    } else {
      setState(() {
        _content = "Something went wrong please try again";
      });
    }
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
                              "Account",
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
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InStockButton(
                        text: "Log Out",
                        onPressed: () async {
                          setState(() {
                            _content = "";
                          });
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  "Are you sure you want to Log Out?",
                                  textAlign: TextAlign.center,
                                ),
                                content: Text(_content),
                                actions: [
                                  Divider(
                                      color: theme.themeData.primaryColorDark),
                                  CupertinoDialogAction(
                                    child: Text("Log Out",
                                        style: theme
                                            .themeData.textTheme.labelMedium
                                            ?.copyWith(
                                                color: theme
                                                    .themeData.highlightColor)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      logOut();
                                    },
                                  ),
                                  Divider(
                                      color: theme.themeData.primaryColorDark),
                                  CupertinoDialogAction(
                                    child: Text("Cancel",
                                        style: theme
                                            .themeData.textTheme.bodySmall),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        theme: theme.themeData,
                        colorOption: InStockButton.primary,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
