import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/authentication/screens/welcome_page.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../utilities/widgets/loading_spinner.dart';
import 'authentication/services/authentication_service.dart';
import 'authentication/services/interfaces/Iauthentication_service.dart';

class AuthCheck extends StatelessWidget {
  IAuthenticationService _authenticationService = AuthenticationService();
  final Widget authenticatedPage;

  AuthCheck(this.authenticatedPage, {super.key}) {
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
              return const Welcome();
            }
            bool tokenIsExpired = Jwt.isExpired(jwtToken);
            if (tokenIsExpired) {
              return const Welcome();
            } else {
              return authenticatedPage;
            }
          }
          return Center(
            child: LoadingSpinner(),
          );
        });
  }
}
