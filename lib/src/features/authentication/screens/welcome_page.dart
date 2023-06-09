import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/authentication/screens/sign_up_page.dart';
import 'package:instock_mobile/src/utilities/widgets/page_route_animation.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/wave.dart';
import '../../../utilities/widgets/welcome_animation.dart';
import 'login_page.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  redirectToLogin() {
    Navigator.push(
      context,
      PageRouteAnimation(page: const Login()),
    );
  }

  redirectToSignUp() {
    Navigator.push(
      context,
      PageRouteAnimation(page: const SignUp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme().themeData;
    return Scaffold(
      //Makes top notification bar specified colour otherwise
      //bar behind notifications appears grey which seems out of place with the rest of the page
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: theme.splashColor),
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
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Container(
                        color: theme.splashColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 48.0, 0, 0),
                          child: Column(children: <Widget>[
                            Text(
                              "Welcome To InStock",
                              style: theme.textTheme.displayLarge,
                              textAlign: TextAlign.center,
                            ),
                            Text("A Small Business's Best Friend",
                                style: theme.textTheme.displaySmall,
                                textAlign: TextAlign.center),
                            Expanded(
                              child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.8,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const WelcomeAnimation()),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      top: MediaQuery.of(context).size.height * 0.7 - 2,
                      child: const InStockWave(),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 60.0, 0, 0),
                child: Column(
                  children: <Widget>[
                    InStockButton(
                      text: "Login",
                      theme: theme,
                      colorOption: InStockButton.accent,
                      onPressed: () {
                        redirectToLogin();
                      },
                    ),
                    InStockButton(
                      text: "Sign Up",
                      theme: theme,
                      colorOption: InStockButton.primary,
                      onPressed: () {
                        redirectToSignUp();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
