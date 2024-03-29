import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:read_me/data/repository/hive_operation.dart';
import 'package:read_me/main.dart';
import 'package:read_me/presentation/pages/home_section/bloc/home_bloc.dart';
import 'package:read_me/presentation/pages/main_page/bloc/main_page_bloc.dart';

import '../../../data/functions/functions.dart';
import '../home_section/variables.dart';
import '../login_section/login.dart';

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

class CustomAwesome extends AwesomeDialog {
  CustomAwesome({required super.context, required content, required value})
      : super(
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          title: 'Are You Sure',
          desc: 'Are you logout from $content',
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false);
            // ClassFunctions.logedPerson(value);
            HiveOperationsImp().addUserDatailes(value);
          },
        );
}

class CustomBottom extends StatelessWidget {
  const CustomBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      bloc: mainPageBloc,
      builder: (context, state) {
        final successState=state as MainPageInitial;
        return ValueListenableBuilder(
            valueListenable: Variables.bottemIndex,
            builder: (context, values, child) {
              // List<Color> bottemItemColor = const [
              //   Color.fromARGB(255, 63, 143, 213),
              //   Color.fromARGB(255, 8, 225, 55),
              //   Color.fromARGB(255, 247, 187, 7),
              //   Colors.red,
              // ];
              return BottomNavigationBar(
                onTap: (value) {
                  mainPageBloc.add(BottemItemClicked(index: value));
                  // Variables.bottemIndex.value = value;
                  // Variables.onTap.value = true;
                },
                currentIndex: successState.index,
                elevation: 5,
                selectedItemColor: const Color.fromARGB(255, 63, 143, 213),
                unselectedItemColor: Colors.white,
                backgroundColor: const Color.fromARGB(57, 85, 85, 87),
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.file_copy,
                    ),
                    label: 'File',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.star,
                    ),
                    label: 'Premium',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                    ),
                    label: 'Favorite',
                  ),
                ],
              );
            });
      },
    );
  }
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
