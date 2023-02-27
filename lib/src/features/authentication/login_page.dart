import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:instock_mobile/src/features/authentication/services/authentication_service.dart';
import 'package:instock_mobile/src/features/authentication/welcome_wave.dart';
import 'package:instock_mobile/src/util/InStockTextInput.dart';
import 'package:instock_mobile/src/util/WidgetOptions/Validators.dart';

import '../../theme/common_theme.dart';
import '../../util/InStockButton.dart';
import '../navigation/navigation_bar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Global formkey for login form
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _loginError;

  handleLogin() async {
    _loginError = null;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthenticationService authenticationService = AuthenticationService();
      Response response =
          await authenticationService.authenticateUser(_email!, _password!);

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
        );
      } else if (response.statusCode == 404) {
        setState(() {
          _loginError = "Whoops something went wrong, please try again";
        });
      } else if (response.statusCode == 500) {
        setState(() {
          _loginError = "Whoops something went wrong, please try again";
        });
      } else if (response.statusCode == 502) {
        _loginError = response.body;
      } else {
        _loginError = response.body;
      }
    }
  }

  displayLoginError(ThemeData theme) {
    if (_loginError != null) {
      return Text(_loginError!, style: theme.textTheme.headlineSmall);
    }
    return Text("");
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme().themeData;
    return MaterialApp(
        //Hides debug banner
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          //Makes top notification bar specified colour otherwise
          //bar behind notifications appears grey which seems out of place with the rest of the page
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light
                .copyWith(statusBarColor: theme.splashColor),
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
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Container(
                              color: theme.splashColor,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 48.0, 0, 0),
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
                              color: theme.primaryColorLight,
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
                                  onSaved: (value) {
                                    _email = value;
                                  }),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 24.0, 0, 0),
                                child: InStockTextInput(
                                  text: 'Password',
                                  theme: theme,
                                  icon: Icons.lock,
                                  validators: [
                                    Validators.validatePassword,
                                    Validators.notNull,
                                    Validators.notBlank,
                                  ],
                                  onSaved: (value) {
                                    _password = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                                child: SizedBox(
                                  width: 180,
                                  child: InStockButton(
                                    text: 'Login',
                                    onPressed: () async {
                                      handleLogin();
                                    },
                                    theme: theme,
                                    colorOption: InStockButton.accent,
                                  ),
                                ),
                              ),
                              displayLoginError(theme),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
