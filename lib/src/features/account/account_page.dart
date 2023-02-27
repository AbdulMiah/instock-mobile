import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/auth_check.dart';

import '../../theme/common_theme.dart';
import '../../util/InStockButton.dart';
import '../../util/SecureStorageService.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme().themeData;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Account"),
              InStockButton(
                  text: "Clear Token",
                  onPressed: () async {
                    //Hacky way to test bearer token is present;
                    SecureStorageService secureStorageService =
                        SecureStorageService();
                    await secureStorageService.delete("bearerToken");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthCheck()),
                    );
                  },
                  theme: theme,
                  colorOption: InStockButton.primary)
            ],
          ),
        ),
      ),
    );
  }
}
