import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/business/screens/shop_connections.dart';
import 'package:instock_mobile/src/features/business/services/business_service.dart';
import 'package:instock_mobile/src/utilities/widgets/no_internet_page.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/validation/validators.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/instock_text_input.dart';
import '../../../utilities/widgets/loading_spinner.dart';
import '../../../utilities/widgets/page_route_animation.dart';
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

  void refreshPage() {
    setState(() {});
  }

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
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null &&
                                  snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                return Center(
                                  child: LoadingSpinner(),
                                );
                              }
                              if (snapshot.error is SocketException) {
                                return NoInternetPage(refreshFunc: refreshPage);
                              }
                              if (snapshot.data == null) {
                                Future.delayed(Duration.zero, () {
                                  Navigator.pushAndRemoveUntil<void>(
                                    context,
                                    PageRouteAnimation(
                                        page: const AddBusiness()),
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
                                      imageUrl: snapshot.data?.imageUrl,
                                      enabled: false,
                                    ),
                                    const Divider(
                                      height: 50.0,
                                      thickness: 1.0,
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                              initialValue:
                                                  snapshot.data?.description,
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
                                          PageRouteAnimation(
                                              page: const ShopConnections()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }),
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
