import 'package:flutter/material.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'authentication/screens/welcome_page.dart';
import 'authentication/services/authentication_service.dart';
import 'navigation/navigation_bar.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = CommonTheme().themeData;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: AuthenticationService.retrieveBearerToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              Map jwtTokenDict = snapshot.data;
              String? jwtToken = jwtTokenDict["bearerToken"];
              if (jwtToken == null) {
                return const Welcome();
              }
              bool tokenIsExpired = Jwt.isExpired(jwtToken);
              if (tokenIsExpired) {
                return const Welcome();
              } else {
                return const NavBar();
              }
            }
            return Center(
              child: CircularProgressIndicator(
                color: theme.splashColor,
              ),
            );
          }),
    );
  }
}
