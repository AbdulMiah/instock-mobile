import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/account/data/user_dto.dart';
import 'package:instock_mobile/src/features/account/screens/contact_us.dart';
import 'package:instock_mobile/src/features/account/services/user_service.dart';
import 'package:instock_mobile/src/features/authentication/services/authentication_service.dart';
import 'package:instock_mobile/src/features/navigation/navigation_bar.dart';
import 'package:instock_mobile/src/utilities/objects/response_object.dart';
import 'package:instock_mobile/src/utilities/widgets/photo_picker.dart';

import '../../theme/common_theme.dart';
import '../../utilities/widgets/instock_button.dart';
import '../../utilities/widgets/no_internet_page.dart';
import '../../utilities/widgets/wave.dart';
import '../auth_check.dart';
import '../authentication/services/interfaces/Iauthentication_service.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final IAuthenticationService _authenticationService = AuthenticationService();
  final UserService _userService = UserService();
  String _content = "";

  redirectToContactUs() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ContactUs()),
    );
  }

  fetchUserData() async {
    UserDto userDto = await _userService.getUser();
    print(userDto);
  }

  logOut() async {
    ResponseObject response = await _authenticationService.logOut();
    if (response.requestSuccess!) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AuthCheck(const NavBar())),
            (route) => false,
      );
      //  I would literally never expect this to happen
    } else {
      setState(() {
        _content = "Something went wrong please try again";
      });
    }
  }

  void refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return Container(
      child: FutureBuilder(
          future: _userService.getUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null &&
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: theme.themeData.splashColor,
                ),
              );
            }
            if (snapshot.error is SocketException) {
              return NoInternetPage(refreshFunc: refreshPage);
            }

            return Scaffold(
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light
                    .copyWith(statusBarColor: theme.themeData.splashColor),
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.25,
                                child: Container(
                                  color: theme.themeData.splashColor,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Column(children: <Widget>[
                                      PhotoPicker(
                                        avatarSize: 120.0,
                                        imageUrl: snapshot.data?.imageUrl,
                                        enabled: false,
                                      ),
                                      Text(
                                        "${snapshot.data.firstName} ${snapshot.data.lastName}",
                                        style: theme.themeData.textTheme.titleMedium,
                                      ),
                                      Text(
                                        "${snapshot.data.email}",
                                        style: theme.themeData.textTheme.bodySmall,
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              Positioned(
                                width: MediaQuery.of(context).size.width,
                                top: MediaQuery.of(context).size.height * 0.25 - 2,
                                child: const InStockWave(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              InStockButton(
                                  onPressed: () {
                                    redirectToContactUs();
                                  },
                                  text: "Contact Us",
                                  theme: theme.themeData,
                                  colorOption: InStockButton.primary
                              ),
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
                                              color: theme.themeData
                                                  .primaryColorDark),
                                          CupertinoDialogAction(
                                            child: Text("Log Out",
                                                style: theme
                                                    .themeData.textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                    color: theme
                                                        .themeData
                                                        .highlightColor)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              logOut();
                                            },
                                          ),
                                          Divider(
                                              color: theme.themeData
                                                  .primaryColorDark),
                                          CupertinoDialogAction(
                                            child: Text("Cancel",
                                                style: theme
                                                    .themeData.textTheme
                                                    .bodySmall),
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
                              ),
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
      ),
    );
  }
}
