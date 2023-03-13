
import 'package:flutter/widgets.dart';
import 'package:read_me/fuctions/functions.dart';
import 'package:read_me/home_section/category_page.dart';
import 'package:read_me/home_section/scroll.list.dart';
import 'variables.dart';

class HalfBody extends StatelessWidget {
  const HalfBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Variables.onTap,
      builder: (context, value, child) => 
      value? Column(
        children: [
          Row(
            children: [
              Image.asset('assets/best.png',height: 30,),
              const SizedBox(
                width: 6,
              ),
             Text('Best seller',style: Variables.mStyle),
            ],
          ),
          ScrollList(category: ClassFunctions.motivation)
    
        ],
      ):const CategoryPage(),
    );
  }
}