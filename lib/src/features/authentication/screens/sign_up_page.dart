import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/authentication/screens/welcome_page.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/back_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme().themeData;
    return MaterialApp(
        //Hides debug banner
        home: Scaffold(
      //Makes top notification bar specified colour otherwise
      //bar behind notifications appears grey which seems out of place with the rest of the page
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: theme.primaryColorDark),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Container(
              color: theme.primaryColorDark,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Sign Up", style: theme.textTheme.displayLarge),
                    Text("Coming Soon", style: theme.textTheme.displayMedium),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 6.0, 0, 0),
                      child: InStockBackButton(
                        page: Welcome(),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    ));
  }
}
