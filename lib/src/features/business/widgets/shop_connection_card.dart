import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/business/data/add_shop_connection_dto.dart';
import 'package:instock_mobile/src/features/business/widgets/shop_sign_in_alert.dart';
import 'package:instock_mobile/src/features/business/widgets/shop_sign_in_success_alert.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../data/business_shop_connections_dto.dart';
import '../services/shop_connection_service.dart';

class ShopConnectionCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String description;
  bool connected;
  final Function(bool) onConnectionChanged;

  ShopConnectionCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    this.connected = false,
    required this.onConnectionChanged,
  }) : super(key: key);

  @override
  State<ShopConnectionCard> createState() => _ShopConnectionCardState();
}

class _ShopConnectionCardState extends State<ShopConnectionCard> {
  ShopConnectionService shopConnectionService = ShopConnectionService();

  // Ref to value notifier https://medium.com/@avnishnishad/flutter-communication-between-widgets-using-valuenotifier-and-valuelistenablebuilder-b51ef627a58b
  // we probably should've used this earlier
  ValueNotifier<String> _content = ValueNotifier<String>("");
  bool _connected = false;
  String _username = "";
  String _password = "";

  // String _pass
  @override
  void initState() {
    super.initState();
    _connected = widget.connected;
  }

  handleShopLoginRequest(AddShopConnectionDto addShopConnectionDto,
      BuildContext dialogContext, ThemeData themeData) async {
    BusinessConnectionsDto connectionsList =
        await shopConnectionService.addShopConnection(addShopConnectionDto);

    if (connectionsList.errorNotification.hasErrors) {
      String error = connectionsList.errorNotification.getFirstErrorMessage()!;
      if (error == "UNAUTHORIZED") {
        _content.value = "Invalid username or password";
      } else {
        _content.value =
            connectionsList.errorNotification.getFirstErrorMessage()!;
      }
    } else {
      Navigator.pop(dialogContext);
      _connected = true;
      widget.onConnectionChanged(_connected);
      if (mounted) {
        setState(() {
          widget.connected = true;
        });
      }
    }
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
                      text: widget.connected ? "Connected" : "Connect",
                      onPressed: () async {
                        setState(() {
                          _content.value = "";
                        });
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            if (widget.connected) {
                              return ShopSignInSuccessAlert(
                                themeData: theme.themeData,
                                text:
                                    "You are already connected to ${widget.title}",
                              );
                            } else {
                              return ShopSignInAlert(
                                shopTitle: widget.title,
                                content: _content,
                                themeData: theme.themeData,
                                onUsernameChanged: (String? value) {
                                  _username = value!.trim();
                                },
                                onPasswordChanged: (String? value) {
                                  _password = value!.trim();
                                },
                                onSubmit: () {
                                  AddShopConnectionDto addShopConnectionDto =
                                      AddShopConnectionDto(
                                    platformName: widget.title,
                                    shopUsername: _username,
                                    shopUserPassword: _password,
                                  );

                                  handleShopLoginRequest(
                                    addShopConnectionDto,
                                    context,
                                    theme.themeData,
                                  );
                                },
                              );
                            }
                          },
                        );
                      },
                      theme: theme.themeData,
                      colorOption: widget.connected
                          ? InStockButton.primary
                          : InStockButton.accent,
                    ),
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
