// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, sort_child_properties_last
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:chatting_app/models/userModel.dart';

class UserChatCard extends StatefulWidget {
  final userModel user;
  const UserChatCard({
    Key? key,
    required this.user,
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
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              imageUrl: widget.user.image ?? '',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(Icons.person)),
            ),
          ),
          title: Text(widget.user.name.toString()),
          subtitle: Text(
            widget.user.about.toString(),
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
          trailing: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10.0)),
          )),
    );
  }
}
