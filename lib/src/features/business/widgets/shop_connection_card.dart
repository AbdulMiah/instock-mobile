import 'package:flutter/material.dart';
import 'package:instock_mobile/src/utilities/validation/validators.dart';
import 'package:instock_mobile/src/utilities/widgets/instock_text_input.dart';
import 'package:lottie/lottie.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/instock_button.dart';

class ShopConnectionCard extends StatefulWidget {
  const ShopConnectionCard({Key? key}) : super(key: key);

  @override
  State<ShopConnectionCard> createState() => _ShopConnectionCardState();
}

class _ShopConnectionCardState extends State<ShopConnectionCard> {
  String? _content = "";
  bool connected = false;

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return Container(
      decoration: BoxDecoration(
        color: theme.themeData.cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              ),
              child: const Image(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mock Shop",
                      style: theme.themeData.textTheme.headlineMedium,
                      overflow: TextOverflow.fade),
                  Text("Shop all things stocked and mocked",
                      style: theme.themeData.textTheme.bodySmall,
                      overflow: TextOverflow.fade),
                  InStockButton(
                      icon: Icons.power_rounded,
                      text: "Connect",
                      onPressed: () async {
                        setState(() {
                          _content = "";
                        });
                        if (!connected) {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  "Sign In To Mock Shop?",
                                  textAlign: TextAlign.center,
                                ),
                                content:
                                    _content == null ? null : Text(_content!),
                                actions: [
                                  InStockTextInput(
                                    text: "Username",
                                    theme: theme.themeData,
                                    validators: [
                                      Validators.longLength,
                                    ],
                                  ),
                                  Padding(
                                    padding: theme.textFieldPadding,
                                    child: InStockTextInput(
                                      text: "Password",
                                      theme: theme.themeData,
                                      validators: [Validators.longLength],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 12.0, 6.0, 4.0),
                                    child: InStockButton(
                                        text: "Submit",
                                        onPressed: () {
                                          print("Clicky");
                                        },
                                        theme: theme.themeData,
                                        colorOption: InStockButton.accent),
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  "You are connected to Mock Shop",
                                  textAlign: TextAlign.center,
                                ),
                                content: Lottie.asset(
                                  'lib/src/images/animations/confirmed_tick.json',
                                  repeat: false,
                                ),
                                actions: [
                                  InStockButton(
                                      text: "Ok",
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the AlertDialog
                                      },
                                      theme: theme.themeData,
                                      colorOption: InStockButton.accent),
                                ],
                              );
                            },
                          );
                        }
                      },
                      theme: theme.themeData,
                      colorOption: InStockButton.accent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
