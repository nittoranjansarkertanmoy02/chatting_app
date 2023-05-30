// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

import 'package:chatting_app/models/userModel.dart';

class UserChatCard extends StatefulWidget {
  final userModel userMODEL;
  const UserChatCard({
    Key? key,
    required this.userMODEL,
  }) : super(key: key);

  @override
  State<UserChatCard> createState() => _UserChatCardState();
}

class _UserChatCardState extends State<UserChatCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: const EdgeInsets.all(5.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[400],
          child: const Icon(Icons.person),
        ),
        title: Text(widget.userMODEL.name.toString()),
        subtitle: Text(
          widget.userMODEL.about.toString(),
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
        trailing: const Text(
          '12:00AM',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
