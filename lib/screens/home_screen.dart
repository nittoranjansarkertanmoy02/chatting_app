import 'dart:convert';

import 'package:chatting_app/auth/login_screen.dart';
import 'package:chatting_app/constants/firebases_constants.dart';
import 'package:chatting_app/models/userModel.dart';
import 'package:chatting_app/widgets/user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<userModel> list = [];
  @override
  void initState() {
    //full screen----------------------
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

//SignOut-----------------------
  _signOUT() async {
    await FirebaseConstants.auth.signOut();
    await GoogleSignIn().signOut().then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: Colors.white,
      ),
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Chatting App',
          style: TextStyle(
            letterSpacing: 1.8,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
          PopupMenuButton(
              child: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () {
                          _signOUT();
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.person),
                            10.widthBox,
                            const Text('Sign Out'),
                          ],
                        ))
                  ])
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseConstants.fireStore.collection('users').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              final data = snapshot.data?.docs;
              list = data!.map((e) => userModel.fromJson(e.data())).toList();
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  physics: const BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return UserChatCard(
                      userMODEL: list[index],
                    );
                  },
                );
              }
          }
          return const Center(
            child: Text(
              'No Connection Found',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.message_outlined),
      ),
    );
  }
}
