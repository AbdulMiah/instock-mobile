import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/account/screens/account_page.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/back_button.dart';
import '../../../utilities/widgets/wave.dart';

class TermsPrivacy extends StatefulWidget {
  const TermsPrivacy({Key? key}) : super(key: key);

  @override
  State<TermsPrivacy> createState() => _TermsPrivacyState();
}

class _TermsPrivacyState extends State<TermsPrivacy> {
  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return Scaffold(
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
                                padding: const EdgeInsets.fromLTRB(30, 8, 30, 0),
                                child: Text(
                                  "Terms & Privacy",
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
                                page: AccountPage(),
                                colorOption: InStockBackButton.secondary,
                              )
                          ),
                          Positioned(
                            width: MediaQuery.of(context).size.width,
                            top: MediaQuery.of(context).size.height * 0.05 - 2,
                            child: const InStockWave(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text("Coming Soon!"),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
