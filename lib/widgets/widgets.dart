import 'package:flutter/material.dart';
import 'package:read_me/home_section/variables.dart';

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


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:Variables.mColor,
      title: Text('My App'),
      centerTitle: true,
      actions: [
        Switch(
          value: true,
          onChanged: (bool value) {
            // Handle switch value change
          },
        ),
      ],
    );
  }
}


