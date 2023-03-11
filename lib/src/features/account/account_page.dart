import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/auth_check.dart';
import 'package:instock_mobile/src/utilities/services/secure_storage_service.dart';

import '../../theme/common_theme.dart';
import '../../utilities/services/interfaces/Isecure_storage_service.dart';
import '../../utilities/widgets/instock_button.dart';

class AccountPage extends StatefulWidget {
  AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState(SecureStorageService());

//Hacky way to test bearer token is present;
}

class _AccountPageState extends State<AccountPage> {
  ISecureStorageService _secureStorageService;

  _AccountPageState(this._secureStorageService);

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme().themeData;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("Account"),
              InStockButton(
                text: "Clear Token",
                onPressed: () async {
                  await _secureStorageService.delete("bearerToken");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthCheck()),
                  );
                },
                theme: theme,
                colorOption: InStockButton.primary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
