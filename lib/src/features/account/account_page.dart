import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/authentication/services/authentication_service.dart';
import 'package:instock_mobile/src/utilities/objects/response_object.dart';

import '../../theme/common_theme.dart';
import '../../utilities/widgets/instock_button.dart';
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
    print("Yesss");
    ResponseObject response = await _authenticationService.logOut();
    if (response.requestSuccess!) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AuthCheck()),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("Account"),
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
                        title: Text(
                          "Are you sure you want to Log Out?",
                          textAlign: TextAlign.center,
                        ),
                        content: Text(_content),
                        actions: [
                          Divider(color: theme.themeData.primaryColorDark),
                          CupertinoDialogAction(
                            child: Text("Log Out",
                                style: theme.themeData.textTheme.labelMedium
                                    ?.copyWith(
                                        color: theme.themeData.highlightColor)),
                            onPressed: () {
                              Navigator.pop(context);
                              logOut();
                            },
                          ),
                          Divider(color: theme.themeData.primaryColorDark),
                          CupertinoDialogAction(
                            child: Text("Cancel",
                                style: theme.themeData.textTheme.bodySmall),
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
      ),
    );
  }
}
