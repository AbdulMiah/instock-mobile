import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/business/screens/shop_connections.dart';
import 'package:instock_mobile/src/features/business/services/business_service.dart';

import 'package:http/http.dart' as http;
import '../../../theme/common_theme.dart';
import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/instock_text_input.dart';
import '../../../utilities/widgets/photo_picker.dart';
import '../../../utilities/widgets/wave.dart';
import 'add_business_page.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({super.key});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  final _formKey = GlobalKey<FormState>();

  final BusinessService _businessService = BusinessService();

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: theme.themeData.splashColor),
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                    child: SizedBox(
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
                                  "Your Business",
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
                          FutureBuilder(
                              future: _businessService.getBusiness(http.Client()),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.data == null && snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: theme.themeData.splashColor,
                                    ),
                                  );
                                }
                                if (snapshot.error is SocketException) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "No Internet Connection",
                                          style: theme
                                              .themeData.textTheme.bodyLarge
                                              ?.merge(const TextStyle(fontSize: 30)),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          "Please check your internet connection and try again",
                                          style: theme.themeData.textTheme.bodySmall,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 40),
                                        InStockButton(
                                          onPressed: () {
                                            setState(() {});
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
                                if (snapshot.data == null) {
                                  Future.delayed(Duration.zero, () {
                                    Navigator.pushAndRemoveUntil<void>(
                                      context,
                                      MaterialPageRoute<void>(builder: (context) => const AddBusiness()),
                                          (route) => false,
                                    );
                                  });
                                }

                                return Padding(
                                  padding: const EdgeInsets.all(60.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      PhotoPicker(
                                        image: snapshot.data?.logo,
                                        enabled: false,
                                      ),
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
                                              enable: false,
                                              text: 'Name',
                                              initialValue: snapshot.data?.name,
                                              theme: theme.themeData,
                                              icon: null,
                                              validators: const [
                                                Validators.notNull,
                                                Validators.notBlank,
                                                Validators.shortLength,
                                                Validators.nameValidation,
                                              ],
                                            ),
                                            Padding(
                                              padding: theme.textFieldPadding,
                                              child: InStockTextInput(
                                                enable: false,
                                                text: 'Description',
                                                initialValue: snapshot.data?.description,
                                                theme: theme.themeData,
                                                icon: null,
                                                maxLines: 4,
                                                validators: const [
                                                  Validators.notNull,
                                                  Validators.notBlank,
                                                  Validators.longLength
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 50),
                                      InStockButton(
                                        text: 'Shop Connections',
                                        theme: theme.themeData,
                                        colorOption: InStockButton.primary,
                                        icon: Icons.shopping_bag_outlined,
                                        secondaryIcon: Icons.arrow_forward,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const ShopConnections()),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
