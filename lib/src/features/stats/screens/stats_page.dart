import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/stats/services/stats_service.dart';
import 'package:instock_mobile/src/features/stats/widgets/category_stats.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/wave.dart';
import '../../authentication/services/authentication_service.dart';
import '../data/stats_dto.dart';
import '../widgets/overview_stats.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final StatsService _statsService = StatsService(AuthenticationService());

  String? _dropdownCategory;
  String? lastSelected;

  var items = [];

  void _updateCategory(String value) {
    setState(() {
      _dropdownCategory = value.toLowerCase();
    });
  }

  List<String> extractCategories(StatsDto statsDto) {
    List<String> res = [];
    var perfByCat = statsDto.categoryStats;
    print("perfByCat: $perfByCat");
    for (final perfSection in perfByCat.entries) {
      final key = perfSection.key;
      res.add(key);
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: theme.themeData.splashColor),
        child: SafeArea(
          child: SingleChildScrollView(
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
                              "Stats",
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
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                  child: Text(
                    "Shop Overview",
                    style: theme.themeData.textTheme.headlineMedium
                        ?.merge(const TextStyle(fontSize: 24)),
                  ),
                ),
                FutureBuilder(
                    future: _statsService.getStats(http.Client()),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null &&
                          snapshot.connectionState == ConnectionState.waiting) {
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
                                style: theme.themeData.textTheme.bodyLarge
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
                      StatsDto statsDto = snapshot.data;
                      // Set dropdown list to categories from request
                      List<String> dropdownItems = extractCategories(statsDto);
                      // If the user hasn't made a selection, default to first item
                      lastSelected ??= dropdownItems.first;
                      _dropdownCategory = lastSelected!;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 12.0, 0, 0),
                                    child: Text("Shop Performance",
                                        style: theme.themeData.textTheme
                                            .headlineMedium),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          OverviewStats(statsDto: snapshot.data, theme: theme),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Text(
                              "Performance By Category",
                              style: theme.themeData.textTheme.headlineMedium
                                  ?.merge(const TextStyle(fontSize: 24)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 12),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 50,
                              child: DropdownButton(
                                value: lastSelected,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: dropdownItems.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _updateCategory(newValue!);
                                    lastSelected = newValue;
                                  });
                                },
                                style: theme.themeData.textTheme.bodySmall,
                                dropdownColor:
                                    theme.themeData.primaryColorLight,
                                iconEnabledColor:
                                    theme.themeData.primaryColorDark,
                                isExpanded: true,
                                underline: Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: theme.themeData.primaryColorDark,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          CategoryStats(
                              statsDto: snapshot.data,
                              updateCategory: _updateCategory,
                              dropdownCategory: _dropdownCategory!)
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
