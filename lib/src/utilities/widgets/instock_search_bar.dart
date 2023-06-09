import 'package:flutter/material.dart';

//ignore: must_be_immutable
class InStockSearchBar extends StatefulWidget {
  InStockSearchBar(
      {super.key,
      required this.text,
      required this.theme,
      required this.controller,
      this.onClear,
      this.hintText,
      this.icon,
      this.textInputAction = TextInputAction.search,
      this.onChanged,
      this.enable = true});

  final ThemeData theme;
  final String text;
  final String? hintText;
  final void Function(String?)? onChanged;
  final void Function()? onClear;
  IconData? icon;
  TextInputAction textInputAction = TextInputAction.search;
  bool enable = true;
  final TextEditingController controller;

  @override
  State<InStockSearchBar> createState() => _InStockSearchBarState();
}

class _InStockSearchBarState extends State<InStockSearchBar> {
  bool _showClearIcon = false;
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
                onChanged: (text) {
                  setState(() {
                    _showClearIcon = text.isNotEmpty;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(text);
                  }
                },
                enableSuggestions: true,
                autocorrect: true,
                cursorColor: widget.theme.primaryColorDark,
                textInputAction: widget.textInputAction,
                decoration: InputDecoration(
                  labelText: widget.text,
                  labelStyle: widget.theme.textTheme.labelMedium,
                  hintText: widget.hintText,
                  prefixIcon: widget.icon != null
                      ? Icon(widget.icon)
                      : const Icon(Icons.search),
                  prefixIconColor: widget.theme.primaryColorDark,
                  suffixIcon: Visibility(
                    visible: _showClearIcon,
                    child: GestureDetector(
                      onTap: () {
                        widget.onClear!();
                      },
                      child: Icon(
                        Icons.clear,
                        color: widget.theme.primaryColorDark,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    borderSide:
                        BorderSide(color: widget.theme.primaryColorDark),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      borderSide:
                          BorderSide(color: widget.theme.primaryColorDark)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: widget.theme.splashColor)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
