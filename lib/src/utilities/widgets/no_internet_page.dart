import 'package:flutter/material.dart';

import '../../theme/common_theme.dart';
import 'instock_button.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({Key? key, required this.refreshFunc}) : super(key: key);

  final VoidCallback refreshFunc;

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No Internet Connection",
            style: theme.themeData.textTheme.bodyLarge
                ?.merge(const TextStyle(fontSize: 30)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Please check your internet connection and try again",
            style: theme.themeData.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          InStockButton(
            onPressed: () {
              widget.refreshFunc();
            },
            theme: theme.themeData,
            colorOption: InStockButton.primary,
            text: "Try Again",
            icon: Icons.refresh,
          ),
        ],
      ),
    );
  }
}
