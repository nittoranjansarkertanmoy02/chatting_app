import 'dart:convert';

import 'package:chatting_app/constants/firebases_constants.dart';
import 'package:chatting_app/models/userModel.dart';
import 'package:chatting_app/screens/profile_screen.dart';
import 'package:chatting_app/widgets/drawer_options.dart';
import 'package:chatting_app/widgets/textform_button.dart';
import 'package:chatting_app/widgets/user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  List<userModel> list = [];
  final List<userModel> _searchList = [];
  bool _isSearching = false;

  @override
  void initState() {
    //full screen----------------------
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();

    FirebaseConstants.selfAccountInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: ProfileDrawer(
      //     imageUrl: FirebaseConstants.selfAccountInfo.image.toString(),
      //     name: FirebaseConstants.selfAccountInfo.name.toString(),
      //     email: FirebaseConstants.selfAccountInfo.email.toString()),
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        elevation: 0.0,
        title: const Text(
          'Chatting App',
          style: TextStyle(
            letterSpacing: 1.8,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (list.isNotEmpty) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      user: FirebaseConstants.selfAccountInfo,
                    ),
                  ),
                );
              } else {
                // Handle the case when the list is empty or not loaded yet
              }
            },
            icon: const Icon(CupertinoIcons.person_alt_circle),
          ),

          // PopupMenuButton(
          //     child: const Icon(Icons.more_vert),
          //     itemBuilder: (context) => [
          //           PopupMenuItem(
          //               onTap: () {
          //                 _signOUT();
          //               },
          //               child: Row(
          //                 children: [
          //                   const Icon(Icons.person),
          //                   10.widthBox,
          //                   const Text('Sign Out'),
          //                 ],
          //               ))
          //         ])
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              10.heightBox,
              TextFormButton(
                textt: 'Search',
                iconn: const Icon(CupertinoIcons.search),
                controller: searchController,
                onChanged: (val) {
                  _searchList.clear();
                  for (var i in list) {
                    if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                        i.email!.toLowerCase().contains(val.toLowerCase())) {
                      _searchList.add(i);
                    }

                    setState(() {
                      _searchList;
                    });
                  }
                },
              ),
              20.heightBox,
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseConstants.getAllUsers(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        final data = snapshot.data?.docs;
                        list = data!
                            .map((e) => userModel.fromJson(e.data()))
                            .toList();

                        if (snapshot.hasData) {
                          print('Data${json.encode(list)}');
                          return ListView.builder(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01),
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                _isSearching ? _searchList.length : list.length,
                            itemBuilder: (context, index) {
                              return UserChatCard(
                                user: _isSearching
                                    ? _searchList[index]
                                    : list[index],
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.message_outlined),
      ),
      // bottomNavigationBar: BottomNavigationBar(items: const [
      //   BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //   BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settiings'),
      //   BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Person'),
      // ]),
    );
  }
}
