import 'package:flutter/material.dart';
import 'package:read_me/home_section/variables.dart';
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.appBackground,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Variables.mColor,
          centerTitle: true,
          title: Text(
            'Settings',
            style: Variables.mStyle,
          )),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Variables.mColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 17, 17, 18),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 35, 10, 15),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(Variables.userProfile!),
                            ),
                            title: Text(
                              Variables.userfullName!,
                              style: Variables.mStyle,
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          Row(
                            children: const [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Account settings',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          const ListTile(
                            title: Text(
                              'Edit profile',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                          const ListTile(
                            title: Text(
                              'Contact us',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                          const ListTile(
                            title: Text(
                              'Invite Friends',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                          const ListTile(
                            title: Text(
                              'About us',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                          const ListTile(
                            title: Text(
                              'Terms and Conditions',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton.icon(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Variables.mColor)),
              onPressed: () {},
              label: Text(
                'Logout',
                style: Variables.mStyle,
              ),
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
