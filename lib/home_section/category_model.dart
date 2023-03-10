import 'package:flutter/material.dart';
import 'package:read_me/fuctions/functions.dart';
import 'package:read_me/home_section/half_body.dart';
import 'package:read_me/home_section/variables.dart';

import '../model/model_story.dart';

class CategoryModel extends StatelessWidget {
  const CategoryModel({super.key, required this.image, required this.name, required this.category});
  final String image;
  final String name;
  final ValueNotifier<List<Story>> category;

  // final Function route;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
           Variables.onTap.value=false;
            
            Variables.category.value=category;
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => route(),));
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
