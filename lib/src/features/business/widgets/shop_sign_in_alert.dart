import 'package:flutter/material.dart';

import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/instock_text_input.dart';

class ShopSignInAlert extends StatelessWidget {
  final String? content;
  final ThemeData themeData;
  final ValueChanged<String?> onUsernameChanged;
  final ValueChanged<String?> onPasswordChanged;
  final VoidCallback onSubmit;

  ShopSignInAlert({
    required this.content,
    required this.themeData,
    required this.onUsernameChanged,
    required this.onPasswordChanged,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Sign In To Mock Shop?",
        textAlign: TextAlign.center,
      ),
      content: content == null ? null : Text(content!),
      actions: [
        InStockTextInput(
          text: "Email / Username",
          theme: themeData,
          onChanged: onUsernameChanged,
          validators: [
            Validators.longLength,
          ],
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: InStockTextInput(
            text: "Password",
            onChanged: onPasswordChanged,
            theme: themeData,
            validators: [Validators.longLength],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 12.0, 6.0, 4.0),
          child: InStockButton(
            text: "Submit",
            onPressed: onSubmit,
            theme: themeData,
            colorOption: InStockButton.accent,
          ),
        ),
      ],
    );
  }
}
