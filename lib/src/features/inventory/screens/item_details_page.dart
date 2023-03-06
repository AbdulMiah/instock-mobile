import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/inventory/screens/inventory_page.dart';
import 'package:instock_mobile/src/utilities/widgets/instock_text_input.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/back_button.dart';
import '../../../utilities/widgets/wave.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails(
      {super.key,
      required this.itemName,
      required this.itemSKU,
      required this.itemStockNo,
      required this.itemOrdersNo,
      this.itemWarning});

  final String itemName;
  final String itemSKU;
  final String itemStockNo;
  final String itemOrdersNo;
  final String? itemWarning;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  String? _name;
  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light
              .copyWith(statusBarColor: theme.themeData.splashColor),
          child: SingleChildScrollView(
            child: SafeArea(
                child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: Container(
                            color: theme.themeData.splashColor,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Text(
                                widget.itemName,
                                style: theme.themeData.textTheme.bodyMedium
                                    ?.merge(const TextStyle(fontSize: 24)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                            top: 10, right: 10, child: Icon(Icons.edit)),
                        Positioned(
                            top: 10,
                            left: 10,
                            child: InStockBackButton(
                              page: const Inventory(),
                              colorOption: InStockBackButton.secondary,
                            )),
                        Container(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.height * 0.3,
                              child: const Image(
                                image: NetworkImage(
                                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.05 - 2,
                          child: InStockWave(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InStockTextInput(
                              text: "Name",
                              theme: theme.themeData,
                              icon: null,
                              validators: const [Validators.notBlank],
                              onSaved: (value) {
                                _name = value;
                              }),
                          InStockTextInput(
                              text: "Category",
                              theme: theme.themeData,
                              icon: null,
                              validators: const [Validators.notBlank],
                              onSaved: (value) {
                                _name = value;
                              }),
                          InStockTextInput(
                              text: "SKU",
                              theme: theme.themeData,
                              icon: null,
                              validators: const [Validators.notBlank],
                              onSaved: (value) {
                                _name = value;
                              })
                        ]),
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
