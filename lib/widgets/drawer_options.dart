// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DrawerOpyions extends StatelessWidget {
  final Function()? onTap;
  final String texxt;
  final Icon iconn;
  const DrawerOpyions({
    Key? key,
    this.onTap,
    required this.texxt,
    required this.iconn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: ListTile(
        onTap: onTap,
        title: Text(texxt),
        leading: iconn,
      ),
    );
  }
}
