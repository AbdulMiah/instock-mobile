import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/inventory/services/item_service.dart';
import 'package:instock_mobile/src/features/inventory/widgets/sku_text_input.dart';
import 'package:instock_mobile/src/utilities/widgets/instock_icon_button.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/objects/response_object.dart';
import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/instock_text_input.dart';
import '../../../utilities/widgets/photo_picker.dart';
import '../../../utilities/widgets/wave.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  ItemService itemService = ItemService();
  String? _itemName;
  String? _category;
  String? _stockLevel;
  String? _sku;
  String? _addItemError;
  String? _addItemSuccess;

  handleAddItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ResponseObject response =
      await itemService.addItem(_itemName!, _category!, _stockLevel!, _sku!);
      if (response.statusCode == 201) {
        setState(() {
          _addItemError = null;
          _addItemSuccess = "Successfully added a item to your inventory.";
        });
      } else if (response.statusCode == 401) {
        setState(() {
          _addItemError = "Whoops something went wrong, please try again";
        });
      } else if (response.statusCode == 400) {
        setState(() {
          var data = json.decode(response.message);
          String duplicateName = data['errors']['duplicateItemName'].toString();
          String duplicateSku = data['errors']['duplicateSKU'].toString();

          if (duplicateName != "null" && duplicateSku != "null") {
            _addItemError = "${duplicateName.substring(1, duplicateName.length - 1)}\n\n${duplicateSku.substring(1, duplicateSku.length - 1)}";
          } else if (duplicateName != "null") {
            _addItemError = duplicateName.substring(1, duplicateName.length - 1);
          } else if (duplicateSku != "null") {
            _addItemError = duplicateSku.substring(1, duplicateSku.length - 1);
          }
        });
      } else {
        setState(() {
          _addItemError = response.message;
        });
      }
    }
  }

  displayMessage(ThemeData theme) {
    if (_addItemError != null) {
      return Text(_addItemError!, style: theme.textTheme.headlineSmall);
    } else if (_addItemSuccess != null) {
      return Text(_addItemSuccess!, style: theme.textTheme.labelSmall);
    }
    return const Text("");
  }

  String generateUuid() {
    var random = Random();
    var uuid = '';
    for (var i = 0; i < 12; i++) {
      if (i == 3 || i == 6 || i == 9) {
        uuid += '-';
      }
      var hex = random.nextInt(16).toRadixString(16);
      uuid += hex.toUpperCase();
    }
    return uuid;
  }

  void generateRandomSku() {
    String uuid = generateUuid();
    _controller.text = uuid;
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme().themeData;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light
              .copyWith(statusBarColor: theme.splashColor),
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
                                color: theme.splashColor,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: Text(
                                    "Add Item",
                                    style: theme.textTheme.bodyMedium
                                        ?.merge(const TextStyle(fontSize: 24)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.05 - 2,
                              child: const InStockWave(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(60.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const PhotoPicker(),
                            const Divider(
                              height: 50.0,
                              thickness: 1.0,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InStockTextInput(
                                    text: 'Name',
                                    theme: theme,
                                    icon: null,
                                    validators: const [
                                      Validators.notNull,
                                      Validators.notBlank,
                                      Validators.shortLength,
                                      Validators.noSpecialChars
                                    ],
                                    onSaved: (value) {
                                      _itemName = value;
                                    },
                                  ),
                                  InStockTextInput(
                                    text: 'Category',
                                    theme: theme,
                                    icon: null,
                                    validators: const [
                                      Validators.notNull,
                                      Validators.notBlank,
                                    ],
                                    onSaved: (value) {
                                      _category = value;
                                    },
                                  ),
                                  InStockTextInput(
                                    text: 'Stock Level',
                                    theme: theme,
                                    isNumber: true,
                                    icon: null,
                                    validators: const [
                                      Validators.notNull,
                                      Validators.notBlank,
                                    ],
                                    onSaved: (value) {
                                      _stockLevel = value.toString();
                                    },
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 150.0,
                                         child: SkuTextInput(
                                            text: 'SKU Number',
                                            theme: theme,
                                            icon: null,
                                            controller: _controller,
                                            validators: const [
                                              Validators.notNull,
                                              Validators.notBlank,
                                            ],
                                            onSaved: (value) {
                                              _sku = value;
                                            },
                                         )
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        height: 60.0,
                                        width: 80.0,
                                        child: InStockIconButton(
                                          onPressed: () {
                                            generateRandomSku();
                                          },
                                          theme: theme,
                                          colorOption: InStockIconButton.accent,
                                          icon: Icons.sync,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            displayMessage(theme),
                            const SizedBox(height: 20),
                            InStockButton(
                              text: 'Add Item',
                              theme: theme,
                              colorOption: InStockButton.accent,
                              onPressed: () async {
                                handleAddItem();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
