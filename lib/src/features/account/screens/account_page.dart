import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/account/screens/account_details.dart';
import 'package:instock_mobile/src/features/account/screens/contact_us.dart';
import 'package:instock_mobile/src/features/account/screens/notifications.dart';
import 'package:instock_mobile/src/features/account/screens/payment_details.dart';
import 'package:instock_mobile/src/features/account/screens/terms_privacy.dart';
import 'package:instock_mobile/src/features/account/services/user_service.dart';
import 'package:instock_mobile/src/features/account/widgets/logout_dialog.dart';
import 'package:instock_mobile/src/utilities/widgets/page_route_animation.dart';
import 'package:instock_mobile/src/utilities/widgets/photo_picker.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/loading_spinner.dart';
import '../../../utilities/widgets/no_internet_page.dart';
import '../../../utilities/widgets/wave.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final UserService _userService = UserService();

  redirectToPage(Widget page) {
    Navigator.push(context, PageRouteAnimation(page: page));
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
              return const Center(
                child: LoadingSpinner(),
              );
            }
            if (snapshot.error is SocketException) {
              return NoInternetPage(refreshFunc: refreshPage);
            }

            return Scaffold(
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light
                    .copyWith(statusBarColor: theme.themeData.splashColor),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: Column(children: <Widget>[
                                    PhotoPicker(
                                      avatarSize: 120.0,
                                      imageUrl: snapshot.data?.imageUrl,
                                      enabled: false,
                                    ),
                                    Text(
                                      "${snapshot.data.firstName} ${snapshot.data.lastName}",
                                      style:
                                          theme.themeData.textTheme.titleMedium,
                                    ),
                                    Text(
                                      "${snapshot.data.email}",
                                      style:
                                          theme.themeData.textTheme.bodySmall,
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            Positioned(
                              width: MediaQuery.of(context).size.width,
                              top:
                                  MediaQuery.of(context).size.height * 0.25 - 2,
                              child: const InStockWave(),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InStockButton(
                                  onPressed: () {
                                    redirectToPage(
                                        AccountDetails(userDto: snapshot.data));
                                  },
                                  text: "Account",
                                  theme: theme.themeData,
                                  colorOption: InStockButton.secondary,
                                  icon: Icons.person_outlined,
                                  secondaryIcon: Icons.arrow_forward,
                                  minimumSize: const Size(0, 50),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InStockButton(
                                  onPressed: () {
                                    redirectToPage(const Notifications());
                                  },
                                  text: "Notifications",
                                  theme: theme.themeData,
                                  colorOption: InStockButton.secondary,
                                  icon: Icons.notifications,
                                  secondaryIcon: Icons.arrow_forward,
                                  minimumSize: const Size(0, 50),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InStockButton(
                                  onPressed: () {
                                    redirectToPage(const PaymentDetails());
                                  },
                                  text: "Payment Details",
                                  theme: theme.themeData,
                                  colorOption: InStockButton.secondary,
                                  icon: Icons.credit_card,
                                  secondaryIcon: Icons.arrow_forward,
                                  minimumSize: const Size(0, 50),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InStockButton(
                                  onPressed: () {
                                    redirectToPage(const TermsPrivacy());
                                  },
                                  text: "Terms & Privacy",
                                  theme: theme.themeData,
                                  colorOption: InStockButton.secondary,
                                  icon: Icons.lock,
                                  secondaryIcon: Icons.arrow_forward,
                                  minimumSize: const Size(0, 50),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InStockButton(
                                  onPressed: () {
                                    redirectToPage(const ContactUs());
                                  },
                                  text: "Contact Us",
                                  theme: theme.themeData,
                                  colorOption: InStockButton.secondary,
                                  icon: Icons.chat,
                                  secondaryIcon: Icons.arrow_forward,
                                  minimumSize: const Size(0, 50),
                                ),
                              ),
                              const Spacer(),
                              InStockButton(
                                text: "Log Out",
                                onPressed: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return LogoutDialog(theme: theme);
                                      });
                                },
                                theme: theme.themeData,
                                colorOption: InStockButton.danger,
                                icon: Icons.logout,
                                minimumSize: const Size(0, 50),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
