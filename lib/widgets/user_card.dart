import 'package:flutter/material.dart';

class UserChatCard extends StatefulWidget {
  const UserChatCard({super.key});

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
        title: const Text('User'),
        subtitle: const Text(
          'Hello,Check Message',
          style: TextStyle(
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
