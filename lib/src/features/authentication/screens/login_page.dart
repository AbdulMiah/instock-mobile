import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/authentication/screens/welcome_page.dart';
import 'package:instock_mobile/src/features/authentication/services/authentication_service.dart';
import 'package:instock_mobile/src/features/business/screens/add_business_page.dart';
import 'package:instock_mobile/src/features/business/services/business_service.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/objects/response_object.dart';
import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/back_button.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/instock_text_input.dart';
import '../../../utilities/widgets/wave.dart';
import '../../navigation/navigation_bar.dart';
import '../services/interfaces/Iauthentication_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  IAuthenticationService? _authenticationService;

  _LoginState() {
    _authenticationService = AuthenticationService();
  }

  //Global formkey for login form
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _loginError;
  bool _isLoading = false;

  handleLogin() async {
    _loginError = null;
    //99% sure this isnt doing anything
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      _formKey.currentState!.save();
      AuthenticationService authenticationService = AuthenticationService();
      BusinessService businessService = BusinessService();
      ResponseObject response =
          await authenticationService.authenticateUser(_email!, _password!);

      bool doesBusinessExist = await businessService.doesBusinessExist();

      if (response.statusCode == 200) {
        if (!doesBusinessExist) {
          // Go to Add Business page if user has no business
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddBusiness())
          );
        } else {
          // remove navigation stack and push
          Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(builder: (context) => const NavBar()),
                (route) => false,
          );
        }
      } else if (response.statusCode == 404) {
        setState(() {
          _loginError = "Invalid Username or Password";
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

  toggleLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  displayLoginError(CommonTheme theme) {
    if (_loginError != null) {
      return Text(_loginError!, style: theme.themeData.textTheme.headlineSmall);
    }
    return const Text("");
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return Scaffold(
      //Makes top notification bar specified colour otherwise
      //bar behind notifications appears grey which seems out of place with the rest of the page
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
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Container(
                          color: theme.themeData.splashColor,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 48.0, 0, 0),
                            child: Column(children: <Widget>[
                              Text(
                                "Login",
                                style: theme.themeData.textTheme.displayLarge,
                                textAlign: TextAlign.center,
                              ),
                            ]),
                          ),
                        ),
                      ),
                      const Positioned(
                          top: 10,
                          left: 10,
                          child: InStockBackButton(
                            page: Welcome(),
                            colorOption: InStockButton.primary,
                          )),
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        top: MediaQuery.of(context).size.height * 0.2 - 2,
                        child: const InStockWave(),
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
                              theme: theme.themeData,
                              icon: Icons.person,
                              validators: const [
                                Validators.notNull,
                                Validators.notBlank,
                                Validators.shortLength,
                              ],
                              onSaved: (value) {
                                _email = value;
                              }),
                          Padding(
                            padding: theme.textFieldPadding,
                            child: InStockTextInput(
                              text: 'Password',
                              theme: theme.themeData,
                              icon: Icons.lock,
                              validators: const [
                                Validators.shortLength,
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
                                theme: theme.themeData,
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
    );
  }
}
