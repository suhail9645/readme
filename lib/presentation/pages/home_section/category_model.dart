import 'package:flutter/material.dart';
import 'package:read_me/presentation/pages/home_section/variables.dart';

class CategoryModel extends StatelessWidget {
  const CategoryModel({super.key, required this.image, required this.name,});
  final String image;
  final String name;
  

  // final Function route;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
           Variables.onTap.value=false;
            Variables.categoryName.value=name;
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(image),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          name,
          style: Variables.sStyle,
        )
      ],
    );
  }
}
