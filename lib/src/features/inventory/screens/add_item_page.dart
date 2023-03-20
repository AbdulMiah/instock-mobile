import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/inventory/services/inventory_service.dart';
import 'package:instock_mobile/src/features/navigation/navigation_bar.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/objects/response_object.dart';
import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/instock_text_input.dart';
import '../../../utilities/widgets/photo_picker.dart';
import '../../../utilities/widgets/wave.dart';
import '../../authentication/services/authentication_service.dart';
import '../data/item.dart';
import '../utils/generate_uuid.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final InventoryService _inventoryService =
      InventoryService(AuthenticationService());

  final TextEditingController _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _itemName;
  String? _category;
  String? _stockLevel;
  String? _sku;
  String? _addItemError;

  handleAddItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Item newItem = Item(
          sku: _sku!,
          category: _category!,
          name: _itemName!,
          stock: _stockLevel!);
      ResponseObject response = await _inventoryService.addItem(newItem);

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
        );
      } else if (response.statusCode == 401) {
        setState(() {
          _addItemError = "Whoops something went wrong, please try again";
        });
      } else if (response.statusCode == 400) {
        var data = json.decode(response.body!);
        String duplicateName = data['errors']['duplicateItemName'].toString();
        String duplicateSku = data['errors']['duplicateSKU'].toString();

        if (duplicateName != "null" && duplicateSku != "null") {
          setState(() {
            _addItemError =
                "${duplicateName.substring(1, duplicateName.length - 1)}\n\n${duplicateSku.substring(1, duplicateSku.length - 1)}";
          });
        } else if (duplicateName != "null") {
          setState(() {
            _addItemError =
                duplicateName.substring(1, duplicateName.length - 1);
          });
        } else if (duplicateSku != "null") {
          setState(() {
            _addItemError = duplicateSku.substring(1, duplicateSku.length - 1);
          });
        }
      } else {
        setState(() {
          _addItemError = response.body;
        });
      }
    }
  }

  displayMessage(ThemeData theme) {
    if (_addItemError != null) {
      return Text(_addItemError!, style: theme.textTheme.headlineSmall);
    }
    return const Text("");
  }

  void generateRandomSku() {
    String uuid = generateUuid();
    _controller.text = uuid;
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
                              "Add Item",
                              style: theme.themeData.textTheme.bodyMedium
                                  ?.merge(const TextStyle(fontSize: 24)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        width: MediaQuery.of(context).size.width,
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
                              theme: theme.themeData,
                              validators: const [
                                Validators.notNull,
                                Validators.notBlank,
                                Validators.shortLength,
                                Validators.nameValidation
                              ],
                              onSaved: (value) {
                                _itemName = value;
                              },
                            ),
                            Padding(
                              padding: theme.textFieldPadding,
                              child: InStockTextInput(
                                text: 'Category',
                                theme: theme.themeData,
                                validators: const [
                                  Validators.notNull,
                                  Validators.notBlank,
                                  Validators.shortLength
                                ],
                                onSaved: (value) {
                                  _category = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: theme.textFieldPadding,
                              child: InStockTextInput(
                                text: 'Stock Level',
                                theme: theme.themeData,
                                isNumber: true,
                                validators: const [
                                  Validators.notNull,
                                  Validators.notBlank,
                                ],
                                onSaved: (value) {
                                  _stockLevel = value.toString();
                                },
                              ),
                            ),
                            Padding(
                              padding: theme.textFieldPadding,
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: 150.0,
                                      child: InStockTextInput(
                                        text: 'SKU Number',
                                        theme: theme.themeData,
                                        isUnique: true,
                                        controller: _controller,
                                        validators: const [
                                          Validators.notNull,
                                          Validators.notBlank,
                                        ],
                                        onSaved: (value) {
                                          _sku = value;
                                        },
                                      )),
                                  const Spacer(),
                                  SizedBox(
                                    height: 60.0,
                                    width: 80.0,
                                    child: InStockButton(
                                      onPressed: () {
                                        generateRandomSku();
                                      },
                                      theme: theme.themeData,
                                      colorOption: InStockButton.accent,
                                      icon: Icons.sync,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: theme.textFieldPadding,
                        child: InStockButton(
                          text: 'Add Item',
                          icon: Icons.add,
                          theme: theme.themeData,
                          colorOption: InStockButton.accent,
                          onPressed: () async {
                            handleAddItem();
                          },
                        ),
                      ),
                      displayMessage(theme.themeData),
                    ],
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
