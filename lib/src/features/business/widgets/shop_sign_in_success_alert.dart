import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utilities/widgets/instock_button.dart';

class ShopSignInSuccessAlert extends StatelessWidget {
  final ThemeData themeData;
  final String text;

  final String? secondaryText;

  ShopSignInSuccessAlert({
    Key? key,
    required this.themeData,
    required this.text,
    this.secondaryText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        text,
        textAlign: TextAlign.center,
      ),
      content: Lottie.asset(
        'lib/src/images/animations/confirmed_tick.json',
        repeat: false,
      ),
      actions: [
        if (secondaryText != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
            child: Text(
              secondaryText!,
              style: themeData.textTheme.bodySmall?.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        InStockButton(
          text: "Ok",
          onPressed: () {
            Navigator.pop(context); // Close the AlertDialog
          },
          theme: themeData,
          colorOption: InStockButton.accent,
        ),
      ],
    );
  }
}
