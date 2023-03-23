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
import '../widgets/shop_performance_graph.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final StatsService _statsService = StatsService(AuthenticationService());

  List<String>? categories;
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: theme.themeData.splashColor),
        child: SafeArea(
          child: Center(
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
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                        categories = ["Cards", "Stickers", "Bookmarks"];
                        dropdownValue = categories?.first;
                        StatsDto statsDto = snapshot.data;
                        print("categoes: $categories");
                        return Column(
                          children: [
                            Text("Shop Performance",
                                style:
                                    theme.themeData.textTheme.headlineMedium),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 300,
                              child: ShopPerformanceGraph(
                                salesByMonth: statsDto.salesByMonth,
                                deductionsByMonth: statsDto.deductionsByMonth,
                              ),
                            ),
                            OverviewStats(
                                statsDto: snapshot.data, theme: theme),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                "Performance By Category",
                                style: theme.themeData.textTheme.headlineMedium
                                    ?.merge(const TextStyle(fontSize: 24)),
                              ),
                            ),
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              items: categories!.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            CategoryStats(statsDto: snapshot.data)
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
