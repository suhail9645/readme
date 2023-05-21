import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:read_me/presentation/pages/settings/terms_conditions.dart';
import 'package:read_me/presentation/pages/settings/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/model_user.dart/model_user.dart';
import '../edit_profile/edit_profile.dart';
import '../home_section/variables.dart';
import '../widgets/widgets.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key, required this.user});
  final UserData user;
  final Uri mail = Uri.parse('mailto:${dotenv.env['GMAIL']}');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
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
                  height: height / 3.5,
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
                              backgroundImage: NetworkImage(user.imageUrl ??
                                  'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                            ),
                            title: Text(
                              user.fullName,
                              style: Variables.mStyle,
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Account settings',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPage(user: user),
                                  ));
                            },
                            title: const Text(
                              'Edit profile',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                          ListTile(
                            onTap: () async {
                              await launchUrl(mail);
                            },
                            title: const Text(
                              'Contact us',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Share.share('com.example.read_me');
                            },
                            title: const Text(
                              'Invite Friends',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) =>
                                    CustomBottomSheetForAboutus(),
                              );
                            },
                            title: const Text(
                              'About us',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TermsPage(),
                                  ));
                            },
                            title: const Text(
                              'Terms and Conditions',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            trailing: const Icon(
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
              onPressed: () {
                CustomAwesome(
                        context: context, content: 'README', value: 'logout')
                    .show();
              },
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
