import 'package:flutter/material.dart';

//ignore: must_be_immutable
class InStockSearchBar extends StatefulWidget {
  InStockSearchBar(
  {super.key,
  required this.text,
  required this.theme,
  required this.controller,
  this.hintText,
  this.icon,
  this.textInputAction = TextInputAction.search,
  this.onChanged,
  this.enable = true});

  final ThemeData theme;
  final String text;
  final String? hintText;
  final void Function(String?)? onChanged;
  IconData? icon;
  TextInputAction textInputAction = TextInputAction.search;
  bool enable = true;
  final TextEditingController controller;

  @override
  State<InStockSearchBar> createState() => _InStockSearchBarState();
}

class _InStockSearchBarState extends State<InStockSearchBar> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                  controller: widget.controller,
                  style: widget.theme.textTheme.bodySmall,
                  enabled: widget.enable,
                  onChanged: widget.onChanged,
                  enableSuggestions: true,
                  autocorrect: true,
                  cursorColor: widget.theme.primaryColorDark,
                  textInputAction: widget.textInputAction,
                  decoration: InputDecoration(
                    labelText: widget.text,
                    labelStyle: widget.theme.textTheme.labelMedium,
                    hintText: widget.hintText,
                    prefixIcon: widget.icon != null ? Icon(widget.icon) : const Icon(Icons.search),
                    prefixIconConstraints:
                    BoxConstraints.loose(const Size.fromWidth(1000)),
                    prefixIconColor: widget.theme.primaryColorDark,
                    suffixIcon: widget.controller.text != ""
                        ? IconButton(
                          onPressed: widget.controller.clear,
                          icon: const Icon(Icons.clear),
                        )
                        : null,
                    suffixIconColor: widget.theme.primaryColorDark,
                    errorStyle: widget.theme.textTheme.headlineSmall,
                    errorMaxLines: 5,
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: widget.theme.primaryColorDark),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: widget.theme.primaryColorDark)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: widget.theme.primaryColorDark)
                    ),
                  ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
