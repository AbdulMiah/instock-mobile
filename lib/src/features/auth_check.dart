import 'package:flutter/material.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'authentication/screens/welcome_page.dart';
import 'authentication/services/authentication_service.dart';
import 'navigation/navigation_bar.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = CommonTheme().themeData;
    return MaterialApp(
      home: FutureBuilder(
          future: AuthenticationService.retrieveBearerToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              Map jwtTokenDict = snapshot.data;
              String? jwtToken = jwtTokenDict["bearerToken"];
              if (jwtToken == null) {
                return Welcome();
              }
              bool tokenIsExpired = Jwt.isExpired(jwtToken);
              if (tokenIsExpired) {
                return Welcome();
              } else {
                return NavBar();
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