import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../theme/common_theme.dart';

class HorizontalCategoryList extends StatefulWidget {
  const HorizontalCategoryList(
      {super.key, required this.scrollController, required this.categories});

  final Map<String, int> categories;
  final ItemScrollController scrollController;

  @override
  State<HorizontalCategoryList> createState() => _HorizontalCategoryListState();
}

class _HorizontalCategoryListState extends State<HorizontalCategoryList> {
  int _selectedIndex = 0;
  final _horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 50),
      child: RawScrollbar(
        thumbColor: theme.themeData.primaryColorDark.withOpacity(0.5),
        radius: const Radius.circular(20),
        thickness: 5,
        thumbVisibility: true,
        interactive: false,
        controller: _horizontalScrollController,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          controller: _horizontalScrollController,
          itemCount: widget.categories.length,
          itemBuilder: (BuildContext context, int index) => Container(
            margin: const EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.scrollController.scrollTo(
                    index: widget.categories.values.elementAt(index),
                    duration: const Duration(milliseconds: 500));
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: theme.themeData.primaryColorDark,
                backgroundColor: _selectedIndex == index
                    ? theme.themeData.splashColor.withOpacity(0.5)
                    : Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.categories.keys.elementAt(index)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
