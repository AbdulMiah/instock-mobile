import 'package:flutter/material.dart';

import '../data/connected_item_dto.dart';

class ConnectedShopsCard extends StatefulWidget {
  const ConnectedShopsCard({Key? key, required this.connectedItems }) : super(key: key);

  final List<ConnectedItemDto> connectedItems;

  @override
  State<ConnectedShopsCard> createState() => _ConnectedShopsCardState();
}

class _ConnectedShopsCardState extends State<ConnectedShopsCard> {
  @override
  Widget build(BuildContext context) {
    return Text("You have a connection");
  }
}
