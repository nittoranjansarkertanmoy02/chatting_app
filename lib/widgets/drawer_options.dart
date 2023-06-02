import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatting_app/constants/firebases_constants.dart';
import 'package:chatting_app/models/userModel.dart';
import 'package:flutter/material.dart';

class ProfileDrawer extends StatefulWidget {
  late String imageUrl;
  late String name;
  late String email;

  ProfileDrawer({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  late userModel selfAccountInfo;

  @override
  void initState() {
    super.initState();
    FirebaseConstants.selfAccountInformation().then((value) {
      setState(() {
        selfAccountInfo = FirebaseConstants.selfAccountInfo;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              selfAccountInfo.name ?? '',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            accountEmail: Text(
              selfAccountInfo.email ?? '',
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.height * 0.1,
              ),
              child: CachedNetworkImage(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.4,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
                imageUrl: widget.imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const CircleAvatar(child: Icon(Icons.person)),
              ),
            ),
          ),
          // Add other list items for the drawer here
        ],
      ),
    );
  }
}
