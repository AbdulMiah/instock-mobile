import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/business/widgets/shop_sign_in_alert.dart';
import 'package:instock_mobile/src/features/business/widgets/shop_sign_in_success_alert.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/instock_button.dart';

class ShopConnectionCard extends StatefulWidget {
  const ShopConnectionCard({Key? key}) : super(key: key);

  @override
  State<ShopConnectionCard> createState() => _ShopConnectionCardState();
}

class _ShopConnectionCardState extends State<ShopConnectionCard> {
  String? _content = "";
  bool _connected = false;
  String _username = "";
  String _password = "";

  handleShopLoginRequest(BuildContext dialogContext, ThemeData themeData) {
    // Closes the AlertDialog
    //CODE FOR HANDLING SERVICE GOES HERE
    Navigator.pop(dialogContext);
    print("Submitted");
    setState(() {
      _connected = true;
    });
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShopSignInSuccessAlert(
          text: "You are connected to Mock Shop",
          themeData: themeData,
        );
      },
    );
  }

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
                        if (!_connected) {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ShopSignInAlert(
                                content: '',
                                themeData: theme.themeData,
                                onUsernameChanged: (String? value) {
                                  print(value);
                                },
                                onPasswordChanged: (String? value) {
                                  print(value);
                                },
                                onSubmit: () {
                                  handleShopLoginRequest(
                                      context, theme.themeData);
                                },
                              );
                            },
                          );
                        } else {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ShopSignInSuccessAlert(
                                themeData: theme.themeData,
                                text: "You are already connected to Mock Shop.",
                                secondaryText:
                                    "To disconnect please email us at InstockInventoryTeam@gmail.com",
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
