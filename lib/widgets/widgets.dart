import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:read_me/fuctions/functions.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:read_me/login_section/login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:lottie/lottie.dart';

class CustomIndigator extends SizedBox {
  const CustomIndigator({super.key})
      : super(
          width: 20,
          height: 20,
          child: const CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 3,
          ),
        );
}

class CustomSnackBar extends SnackBar {
  final String contentText;
  CustomSnackBar({super.key, required this.contentText})
      : super(
          content: Text(
            contentText,
            style: const TextStyle(color: Colors.white),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.white, width: 1),
          ),
          duration: const Duration(seconds: 3),
          elevation: 30,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Variables.mColor,
        );
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
 
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back),
      ),
      backgroundColor: Variables.mColor,
      title: Text(
        title,
        style: Variables.mStyle,
      ),
     
      centerTitle: true,
      actions: [],
    );
  }
}

// class CustomAlertBox extends AlertDialog {
//  const CustomAlertBox({super.key})
//       : super(
//             title:const Text(
//           'Are you Sure',
//           style: TextStyle(),
//         ));
// }

class CustomAwesome extends AwesomeDialog {
  CustomAwesome({required super.context, required content})
      : super(
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          title: 'Are You Sure',
          desc: 'Are you logout from $content',
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ));
            ClassFunctions.adminIsLog(false, context);
          },
        );
}

class CustomBottom extends StatelessWidget {
  const CustomBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Variables.bottemIndex,
      builder: (context, values, child) => BottomNavigationBar(
          onTap: (value) {
            Variables.bottemIndex.value = value;
            Variables.onTap.value = true;
          },
          currentIndex: values,
          elevation: 5,
          selectedItemColor: const Color.fromARGB(255, 63, 143, 213),
          unselectedItemColor: Colors.white,
          backgroundColor: const Color.fromARGB(57, 85, 85, 87),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 237, 241, 239),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.file_copy,
                color: Color.fromARGB(255, 8, 225, 55),
              ),
              label: 'File',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                color: Color.fromARGB(255, 247, 187, 7),
              ),
              label: 'Premium',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              label: 'Favorite',
            ),
          ]),
    );
  }
}

class CustomAlertBox extends Alert {
  CustomAlertBox({required super.context, required content})
      : super(
          type: AlertType.warning,
          style: const AlertStyle(backgroundColor: Variables.appBackground),
          // content:Image(image:AssetImage('assets/MOON.jfif'),) ,
          title: "Are you sure",
          desc: content,
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              color: const Color.fromRGBO(0, 179, 134, 1.0),
              child: const Text(
                'YES',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            DialogButton(
              onPressed: () => Navigator.pop(context),
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0)
              ]),
              child: const Text(
                'NO',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        );
}

class CustomAlert extends AlertDialog {
  final Function()? onPress;
  CustomAlert(
      {super.key, required content, required context, required this.onPress})
      : super(
            backgroundColor: Variables.appBackground,
            actionsAlignment: MainAxisAlignment.center,
            title: Lottie.asset('assets/animations/warning.json',
                width: 100, height: 100),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  content,
                  style: Variables.sStyle,
                )
              ],
            ),
            actions: [
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 28, 216, 141),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 216, 28, 110),
                    ),
                  ),
                  onPressed: onPress,
                  
                 
                  child: const Text('Yes'))
            ]);
}
