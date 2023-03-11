import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/authentication/screens/welcome_page.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/objects/response_object.dart';
import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/back_button.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/instock_text_input.dart';
import '../../../utilities/widgets/wave.dart';
import '../../navigation/navigation_bar.dart';
import '../data/sign_up_dto.dart';
import '../services/authentication_service.dart';
import '../services/interfaces/Iauthentication_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState(AuthenticationService());
}

class _SignUpState extends State<SignUp> {
  IAuthenticationService _authenticationService;

  _SignUpState(this._authenticationService) {
    _authenticationService = AuthenticationService();
  }

  //Global formkey for login form
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _signUpError;
  bool _isLoading = false;

  handleLogin() async {
    _signUpError = null;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // To Do
      // validate passwords match
      if (_password != _confirmPassword) {
        setState(() {
          _signUpError = "Passwords do not match";
        });
        return null;
      }

      SignUpDTO userDetails =
          SignUpDTO(_firstName!, _lastName!, _email!, _password!);

      //Auth service handling
      ResponseObject response =
          await _authenticationService.createUserAndAuthenticate(userDetails);
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
        );
      } else if (response.statusCode == 404) {
        setState(() {
          _signUpError = "Whoops something went wrong, please try again";
        });
      } else if (response.statusCode == 500) {
        setState(() {
          _signUpError = "Whoops something went wrong, please try again";
        });
      } else if (response.statusCode == 502) {
        setState(() {
          _signUpError = "Whoops something went wrong, please try again";
        });
      } else {
        setState(() {
          _signUpError = response.message;
        });
      }
    }
  }

  toggleLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  displaySignUpError(ThemeData theme) {
    if (_signUpError != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 36.0),
        child: Text(_signUpError!, style: theme.textTheme.headlineSmall),
      );
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
                .copyWith(statusBarColor: theme.themeData.splashColor),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
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
                            height: MediaQuery.of(context).size.height * 0.18,
                            child: Container(
                              color: theme.themeData.splashColor,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 48.0, 0, 0),
                                child: Column(children: <Widget>[
                                  Text(
                                    "Sign Up",
                                    style:
                                        theme.themeData.textTheme.displayLarge,
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
                                colorOption: InStockButton.primary,
                              )),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.18 - 2,
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
                              Padding(
                                padding: theme.textFieldPadding,
                                child: InStockTextInput(
                                  key: const Key('firstNameTextField'),
                                  text: 'First Name',
                                  theme: theme.themeData,
                                  icon: null,
                                  validators: const [
                                    Validators.notNull,
                                    Validators.notBlank,
                                    Validators.shortLength,
                                    Validators.noNumbers,
                                    Validators.noSpecialCharacters,
                                  ],
                                  onSaved: (value) {
                                    _firstName = value;
                                  },
                                  onChanged: (value) {
                                    _firstName = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding: theme.textFieldPadding,
                                child: InStockTextInput(
                                    key: const Key('lastNameTextField'),
                                    text: 'Last Name',
                                    theme: theme.themeData,
                                    icon: null,
                                    validators: const [
                                      Validators.notNull,
                                      Validators.notBlank,
                                      Validators.shortLength,
                                      Validators.noNumbers,
                                      Validators.noSpecialCharacters,
                                    ],
                                    onChanged: (value) {
                                      _lastName = value;
                                    }),
                              ),
                              Padding(
                                padding: theme.textFieldPadding,
                                child: InStockTextInput(
                                    key: const Key('emailTextField'),
                                    text: 'Email',
                                    theme: theme.themeData,
                                    icon: null,
                                    validators: const [
                                      Validators.notNull,
                                      Validators.notBlank,
                                      Validators.isEmail,
                                    ],
                                    onChanged: (value) {
                                      _email = value;
                                    }),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 24.0, 0, 0),
                                child: InStockTextInput(
                                  key: const Key('passwordTextField'),
                                  text: 'Password',
                                  theme: theme.themeData,
                                  icon: null,
                                  validators: const [
                                    Validators.notNull,
                                    Validators.notBlank,
                                    Validators.validatePassword,
                                  ],
                                  onChanged: (value) {
                                    _password = value;
                                  },
                                  obscureText: true,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 24.0, 0, 0),
                                child: InStockTextInput(
                                  key: const Key('confirmPasswordTextField'),
                                  text: 'Confirm Password',
                                  theme: theme.themeData,
                                  icon: null,
                                  validators: const [
                                    Validators.notNull,
                                    Validators.notBlank,
                                    Validators.validatePassword,
                                  ],
                                  onChanged: (value) {
                                    _confirmPassword = value;
                                  },
                                  obscureText: true,
                                ),
                              ),
                              Padding(
                                padding: theme.textFieldPadding,
                                child: SizedBox(
                                  width: 180,
                                  child: InStockButton(
                                    key: const Key('signUpButton'),
                                    text: 'Sign Up',
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
                              displaySignUpError(theme.themeData),
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
