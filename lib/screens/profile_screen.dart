// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatting_app/auth/login_screen.dart';
import 'package:chatting_app/constants/firebases_constants.dart';
import 'package:chatting_app/functions/utils.dart';
import 'package:chatting_app/screens/home_screen.dart';
import 'package:chatting_app/widgets/click_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chatting_app/models/userModel.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  final userModel user;
  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final aboutController = TextEditingController();
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ));
              },
              icon: const Icon(
                CupertinoIcons.back,
                size: 30,
              )),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                _signOUT();
              },
              icon: const Icon(Icons.logout_rounded),
            )
          ],
          elevation: 0.0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.1),
                    child: CachedNetworkImage(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.4,
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                      imageUrl: widget.user.image ?? '',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const CircleAvatar(child: Icon(Icons.person)),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 90,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 15,
                      shape: const CircleBorder(
                        side: BorderSide(
                          width: 2,
                        ),
                      ),
                      color: Colors.white,
                      child: const Icon(Icons.edit),
                    ),
                  )
                ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Card(
                  margin: const EdgeInsets.all(10.0),
                  elevation: 10.0,
                  child: Text(
                    widget.user.email ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                TextFormField(
                  onSaved: (newValue) =>
                      FirebaseConstants.selfAccountInfo.name = newValue ?? '',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  initialValue: widget.user.name,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      label: const Text('Name')),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    FirebaseConstants.selfAccountInfo.about = newValue ?? '';
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required';
                    }
                  },
                  initialValue: widget.user.about,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.info_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      label: const Text('About')),
                ),
                const SizedBox(
                  height: 25,
                ),
                ClickButton(
                  textt: 'Update',
                  onTapp: () {
                    if (_formKey.currentState!.validate()) {
                      print("Updated");
                      _formKey.currentState!.save();
                      FirebaseConstants.updateInformations().then((value) {
                        return Utils().showMessage('Updated');
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
