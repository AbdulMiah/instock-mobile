import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/business/widgets/shop_sign_in_alert.dart';
import 'package:instock_mobile/src/features/business/widgets/shop_sign_in_success_alert.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/instock_button.dart';

class ShopConnectionCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String description;
  final bool connected;

  const ShopConnectionCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.connected,
  }) : super(key: key);

  @override
  State<ShopConnectionCard> createState() => _ShopConnectionCardState();
}

class _ShopConnectionCardState extends State<ShopConnectionCard> {
  String? _content = "";
  bool _connected = false;
  String _username = "";
  String _password = "";

  // String _pass

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
          text: "You are connected to ${widget.title}",
          themeData: themeData,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _connected = widget.connected;
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0),
                ),
                child: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.imageUrl),
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
                    Text(widget.title,
                        style: theme.themeData.textTheme.headlineMedium,
                        overflow: TextOverflow.fade),
                    Text(widget.description,
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
                                  text:
                                      "You are already connected to ${widget.title}.",
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
      ),
    );
  }
}
