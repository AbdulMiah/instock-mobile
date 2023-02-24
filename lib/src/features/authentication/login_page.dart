import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/authentication/welcome_wave.dart';
import 'package:instock_mobile/src/util/InStockTextInput.dart';
import 'package:instock_mobile/src/util/WidgetOptions/Validators.dart';

import '../../util/InStockButton.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Global formkey for login form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp(
        //Hides debug banner
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          //Makes top notification bar specified colour otherwise
          //bar behind notifications appears grey which seems out of place with the rest of the page
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light
                .copyWith(statusBarColor: Theme.of(context).splashColor),
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
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Container(
                            color: theme.splashColor,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 48.0, 0, 0),
                              child: Column(children: <Widget>[
                                Text(
                                  "Login",
                                  style: theme.textTheme.displayLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.2 - 2,
                          child: WelcomeWave(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60.0, 0, 0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            InStockTextInput(
                              text: 'Email',
                              theme: theme,
                              icon: Icons.person,
                              validators: [
                                Validators.notNull,
                                Validators.notBlank,
                                Validators.isEmail,
                                Validators.shortLength,
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 24.0, 0, 0),
                              child: InStockTextInput(
                                text: 'Password',
                                theme: theme,
                                icon: Icons.lock,
                                validators: [
                                  Validators.validatePassword,
                                  Validators.notNull,
                                  Validators.notBlank,
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                              child: SizedBox(
                                width: 180,
                                child: InStockButton(
                                  text: 'Login',
                                  onPressed: () {
                                    print("Login");
                                    if (_formKey.currentState!.validate()) {
                                      print("Nice");
                                    }
                                  },
                                  theme: theme,
                                  colorOption: InStockButton.accent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
