import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/inventory/data/item.dart';
import 'package:instock_mobile/src/features/inventory/screens/inventory_page.dart';
import 'package:instock_mobile/src/utilities/widgets/instock_text_input.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/back_button.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/wave.dart';
import '../widgets/stock_editor.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key, required this.item, this.itemWarning});

  final Item item;
  final String? itemWarning;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  String? _name;
  String? _category;
  String? _sku;

  I

  confirmDelete(){
    ResponseObject response = await _itemService.delete();
    if (response.requestSuccess!) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AuthCheck()),
      );
      //  I would literally never expect this to happen
    } else {
      setState(() {
        _content = "Something went wrong please try again";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: theme.themeData.splashColor),
        child: SingleChildScrollView(
          child: SafeArea(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
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
                              padding: const EdgeInsets.fromLTRB(30, 8, 30, 0),
                              child: Text(
                                widget.item.name,
                                overflow: TextOverflow.ellipsis,
                                style: theme.themeData.textTheme.bodyMedium
                                    ?.merge(const TextStyle(fontSize: 24)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                            top: 10,
                            left: 10,
                            child: InStockBackButton(
                              page: Inventory(),
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
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            StockEditor(
                              currentStock: widget.item.stockAmount,
                              itemSKU: widget.item.sku,
                              businessId: widget.item.businessId,
                            ),
                            InStockTextInput(
                              key: const Key('itemNameTextField'),
                              text: "Name",
                              theme: theme.themeData,
                              icon: null,
                              validators: const [Validators.notBlank],
                              onSaved: (value) {
                                _name = value;
                              },
                              initialValue: widget.item.name,
                              enable: false,
                            ),
                            InStockTextInput(
                              key: const Key('itemCategoryTextField'),
                              text: "Category",
                              theme: theme.themeData,
                              icon: null,
                              validators: const [Validators.notBlank],
                              onSaved: (value) {
                                _category = value;
                              },
                              initialValue: widget.item.category,
                              enable: false,
                            ),
                            InStockTextInput(
                              key: const Key('itemSkuTextField'),
                              text: "SKU",
                              theme: theme.themeData,
                              icon: null,
                              validators: const [Validators.notBlank],
                              onSaved: (value) {
                                _sku = value;
                              },
                              initialValue: widget.item.sku,
                              enable: false,
                            ),
                            Padding(
                              padding: theme.textFieldPadding,
                              child: InStockButton(
                                  text: "Delete",
                                  onPressed: () {
                                    print("Delete");
                                    await showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
    title: Text(
    "Are you sure you want to Log Out?",
    textAlign: TextAlign.center,
    ),
    content: Text(_content),
    actions: [
    Divider(
    color: theme.themeData.primaryColorDark),
    CupertinoDialogAction(
    child: Text("Log Out",
    style: theme
        .themeData.textTheme.labelMedium
        ?.copyWith(
    color: theme
        .themeData.highlightColor)),
    onPressed: () {
    Navigator.pop(context);
    logOut();
    },
    ),
    Divider(
    color: theme.themeData.primaryColorDark),
    CupertinoDialogAction(
    child: Text("Cancel",
    style: theme
        .themeData.textTheme.bodySmall),
    onPressed: () {
    Navigator.pop(context);
    },
    ),
    ],
    );
    },
    );
    },
                                  },
                                  theme: theme.themeData,
                                  colorOption: InStockButton.danger),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
