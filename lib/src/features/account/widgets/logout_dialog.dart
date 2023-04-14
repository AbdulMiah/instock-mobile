import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';

import '../../../utilities/objects/response_object.dart';
import '../../../utilities/widgets/page_route_animation.dart';
import '../../auth_check.dart';
import '../../authentication/services/authentication_service.dart';
import '../../authentication/services/interfaces/Iauthentication_service.dart';
import '../../navigation/navigation_bar.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({Key? key, required this.theme}) : super(key: key);

  final CommonTheme theme;

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  final IAuthenticationService _authenticationService = AuthenticationService();
  late String content = "";

  logOut() async {
    ResponseObject response = await _authenticationService.logOut();
    if (response.requestSuccess!) {
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteAnimation(page: AuthCheck(const NavBar()), swipeLeft: true),
            (route) => false,
      );
      //  I would literally never expect this to happen
    } else {
      setState(() {
        content = "Something went wrong please try again";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Are you sure you want to Log Out?",
        textAlign: TextAlign.center,
      ),
      content: Text(content),
      actions: [
        Divider(
          color: widget.theme.themeData.primaryColorDark,
        ),
        CupertinoDialogAction(
          child: Text(
            "Log Out",
            style: widget.theme.themeData.textTheme.labelMedium?.copyWith(
              color: widget.theme.themeData.highlightColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            logOut();
          },
        ),
        Divider(
          color: widget.theme.themeData.primaryColorDark,
        ),
        CupertinoDialogAction(
          child: Text(
            "Cancel",
            style: widget.theme.themeData.textTheme.bodySmall,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
