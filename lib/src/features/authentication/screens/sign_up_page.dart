import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/authentication/screens/welcome_page.dart';
import 'package:instock_mobile/src/features/authentication/services/authentication_service.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/objects/response_object.dart';
import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/back_button.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/instock_text_input.dart';
import '../../../utilities/widgets/wave.dart';
import '../../navigation/navigation_bar.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Global formkey for login form
  final _formKey = GlobalKey<FormState>();
  String? _email;

  String? _password;
  String? _loginError;
  bool _isLoading = false;

  handleLogin() async {
    _loginError = null;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthenticationService authenticationService = AuthenticationService();
      ResponseObject response =
          await authenticationService.authenticateUser(_email!, _password!);
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
        );
      } else if (response.statusCode == 404) {
        setState(() {
          _loginError = "Invalid Username or Password";
        });
      } else if (response.statusCode == 500) {
        setState(() {
          _loginError = "Whoops something went wrong, please try again";
        });
      } else if (response.statusCode == 502) {
        _loginError = response.message;
      } else {
        _loginError = response.message;
      }
    }
  }

  toggleLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
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
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Container(
                          color: theme.splashColor,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 48.0, 0, 0),
                            child: Column(children: <Widget>[
                              Text(
                                "Sign Up",
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
                          child: InStockBackButton(
                            page: Welcome(),
                          )),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.15 - 2,
                        child: InStockWave(),
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
                              text: 'First Name',
                              theme: theme,
                              icon: Icons.person,
                              validators: const [
                                Validators.notNull,
                                Validators.notBlank,
                                Validators.shortLength,
                              ],
                              onSaved: (value) {
                                _email = value;
                              }),
                          InStockTextInput(
                              text: 'Last Name',
                              theme: theme,
                              icon: Icons.person,
                              validators: const [
                                Validators.notNull,
                                Validators.notBlank,
                                Validators.shortLength,
                              ],
                              onSaved: (value) {
                                _email = value;
                              }),
                          InStockTextInput(
                              text: 'Email',
                              theme: theme,
                              icon: Icons.person,
                              validators: const [
                                Validators.notNull,
                                Validators.notBlank,
                                Validators.isEmail,
                                Validators.shortLength,
                              ],
                              onSaved: (value) {
                                _email = value;
                              }),
                          InStockTextInput(
                              text: 'Phone Number',
                              theme: theme,
                              icon: null,
                              validators: const [
                                Validators.notNull,
                                Validators.notBlank,
                                Validators.shortLength,
                              ],
                              onSaved: (value) {
                                _email = value;
                              },
                              isPhoneNumber: true),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 24.0, 0, 0),
                            child: InStockTextInput(
                              text: 'Password',
                              theme: theme,
                              icon: Icons.lock,
                              validators: const [
                                Validators.validatePassword,
                                Validators.notNull,
                                Validators.notBlank,
                              ],
                              onSaved: (value) {
                                _password = value;
                              },
                              obscureText: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 24.0, 0, 0),
                            child: InStockTextInput(
                              text: 'Confirm Password',
                              theme: theme,
                              icon: Icons.lock,
                              validators: const [
                                Validators.validatePassword,
                                Validators.notNull,
                                Validators.notBlank,
                              ],
                              onSaved: (value) {
                                _password = value;
                              },
                              obscureText: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                            child: SizedBox(
                              width: 180,
                              child: InStockButton(
                                text: 'Login',
                                onPressed: () async {
                                  toggleLoading(true);
                                  handleLogin();
                                  toggleLoading(false);
                                },
                                theme: theme,
                                colorOption: InStockButton.accent,
                                isLoading: _isLoading,
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
