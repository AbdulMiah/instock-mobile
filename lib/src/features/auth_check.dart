import 'package:flutter/material.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'authentication/services/authentication_service.dart';
import 'authentication/services/interfaces/Iauthentication_service.dart';

class AuthCheck extends StatelessWidget {
  IAuthenticationService _authenticationService = AuthenticationService();
  final Widget page1;
  final Widget page2;

  AuthCheck(this.page1, this.page2, {super.key}) {
    _authenticationService = AuthenticationService();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = CommonTheme().themeData;
    return FutureBuilder(
        future: _authenticationService.retrieveBearerToken(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            Map jwtTokenDict = snapshot.data;
            String? jwtToken = jwtTokenDict["bearerToken"];
            if (jwtToken == null) {
              return page1;
            }
            bool tokenIsExpired = Jwt.isExpired(jwtToken);
            if (tokenIsExpired) {
              return page1;
            } else {
              return page2;
            }
          }
          return Center(
            child: CircularProgressIndicator(
              color: theme.splashColor,
            ),
          );
        }
    );
  }
}
