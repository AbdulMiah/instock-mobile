import 'package:flutter/material.dart';

import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/instock_text_input.dart';

class ShopSignInAlert extends StatelessWidget {
  final String shopTitle;

  // Ref to value notifier https://medium.com/@avnishnishad/flutter-communication-between-widgets-using-valuenotifier-and-valuelistenablebuilder-b51ef627a58b
  // we probably should've used this earlier
  final ValueNotifier<String> content;
  final ThemeData themeData;
  final ValueChanged<String?> onUsernameChanged;
  final ValueChanged<String?> onPasswordChanged;
  final VoidCallback onSubmit;

  ShopSignInAlert({
    required this.shopTitle,
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
      title: Text(
        "Sign In To $shopTitle",
        textAlign: TextAlign.center,
      ),
      content: ValueListenableBuilder<String>(
        valueListenable: content,
        builder: (BuildContext context, String value, Widget? child) {
          // SizedBox.shrink() is a widget that has no size apparently
          // better than using an empty container
          return value.isEmpty
              ? SizedBox.shrink()
              : Text(
                  value,
                  style: themeData.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                );
        },
      ),
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
