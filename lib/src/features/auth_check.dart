import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'authentication/services/authentication_service.dart';
import 'authentication/welcome_page.dart';
import 'navigation/navigation_bar.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              // Map<String, dynamic> payload = Jwt.parseJwt(jwtToken);
              bool tokenIsExpired = Jwt.isExpired(jwtToken);
              if (tokenIsExpired) {
                return Welcome();
              } else {
                return NavBar();
              }
            }
            return Center(
              child: CircularProgressIndicator(
                // backgroundColor: theme.themeData.splashColor,
                color: theme.splashColor,
              ),
            );
          }),
    );
  }
}
