import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:read_me/fuctions/functions.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:read_me/premium_section/premium.dart';
import 'package:read_me/profile_section/edit_profile.dart';
import 'package:read_me/profile_section/favorite_list.dart';
import 'package:read_me/profile_section/file_list.dart';
import 'package:read_me/settings/setting.dart';

import '../file_section/read_file.dart';
import '../model_file/model_file.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 330,
            width: double.infinity,
            child: Image.asset(
              'assets/MOON.jfif',
              fit: BoxFit.fill,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 23, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const SettingPage(),));
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(Variables.userProfile ??
                          'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Variables.userfullName!,
                          style: Variables.mStyle,
                        ),
                        Text(
                          Variables.userName!,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        OutlinedButton(
                            style: const ButtonStyle(
                              side: MaterialStatePropertyAll(
                                BorderSide(color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const EditPage(),
                              ));
                            },
                            child: Text(
                              'Edit Profile',
                              style: Variables.sStyle,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, top: 9, bottom: 20),
                child: SizedBox(
                  height: 36,
                  width: 220,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        backgroundColor:
                            MaterialStatePropertyAll(Variables.mColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PremiumPage(),
                        ));
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_forward),
                          Text(
                            'Upgrade To Premium',
                            style: Variables.sStyle,
                          ),
                          Icon(
                            Icons.star_sharp,
                            color: Colors.amber[600],
                          )
                        ],
                      )),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 46, 47, 55),
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(30),
                      topEnd: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: const MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                    ),
                                  ),
                                ),
                                elevation: currentIndex == 0
                                    ? const MaterialStatePropertyAll(8)
                                    : const MaterialStatePropertyAll(0),
                                backgroundColor: currentIndex == 0
                                    ? const MaterialStatePropertyAll(
                                        Variables.appBackground)
                                    : const MaterialStatePropertyAll(
                                        Color.fromARGB(255, 36, 36, 37)),
                              ),
                              onPressed: () {
                                setState(() {
                                  currentIndex = 0;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 19, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: currentIndex == 0 ? 9 : 6,
                                    ),
                                    Text(
                                      'Favorite',
                                      style: Variables.mStyle,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: const MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                ),
                                elevation: currentIndex == 1
                                    ? const MaterialStatePropertyAll(8)
                                    : const MaterialStatePropertyAll(0),
                                backgroundColor: currentIndex == 1
                                    ? const MaterialStatePropertyAll(
                                        Variables.appBackground)
                                    : const MaterialStatePropertyAll(
                                        Color.fromARGB(255, 35, 36, 42)),
                              ),
                              onPressed: () {
                                setState(() {
                                  currentIndex = 1;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 19, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.file_copy,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: currentIndex == 1 ? 9 : 6,
                                    ),
                                    Text(
                                      'Files',
                                      style: Variables.mStyle,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: currentIndex == 0
                              ? const FavoriteList()
                              : const FileList()),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
