import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:read_me/favorite_section/favorite.dart';
import 'package:read_me/file_section/file.dart';
import 'package:read_me/home_section/home_two.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:read_me/premium_section/premium.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
class FirstHome extends StatefulWidget {
  const FirstHome({super.key});

  @override
  State<FirstHome> createState() => _FirstHomeState();
}

class _FirstHomeState extends State<FirstHome> {
  final List<Widget> pages = [
    HomePageTwo(),
    const FilePage(),
    const PremiumPage(),
    const FavoritePage()
  ];
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  void getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected) {
        showDialogBox();
       
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Variables.bottemIndex,
      builder: (context, value, child) => GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: pages[value]),
    );
  }

  void showDialogBox() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) =>AlertDialog(
        backgroundColor: Variables.appBackground,
        actionsAlignment: MainAxisAlignment.center,
        title: Lottie.asset('assets/animations/no_internet.json',height: 100,width: 100),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No Internet',style: Variables.mStyle,),
          ],
        ),
        actions: [
          ElevatedButton(
            style:const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Variables.mColor)),
            onPressed: () async{
             isDeviceConnected=await InternetConnectionChecker().hasConnection;
            if(isDeviceConnected){
              Navigator.pop(context);
            }
          }, child:const Text('Try again'))
        ],
      )
    );
  }
}
