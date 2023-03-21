
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:read_me/fuctions/functions.dart';
import 'package:read_me/home_section/category_page.dart';
import 'package:read_me/home_section/scroll.list.dart';
import 'package:read_me/model/model_story.dart';
import 'variables.dart';

class HalfBody extends StatelessWidget {
  const HalfBody({super.key, required this.storyValues});
   final Box<Story> storyValues;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Variables.onTap,
      builder: (context, value, child) => 
      value? Padding(
        padding: const EdgeInsets.only(left:8),
        child: Column(
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
            ScrollList( value: storyValues, category: 'Best seller',),
            Row(
              children: [Image.asset('assets/top.png',height: 30,),
                const SizedBox(
                  width: 3,
                ),
                  Text('Top Ten',style: Variables.mStyle),
              ],
            ),
              ScrollList( value: storyValues, category: 'Motivation',),
                 Row(
              children: [Image.asset('assets/new.png',height: 30,),
                const SizedBox(
                  width: 3,
                ),
                  Text('Newly Published',style: Variables.mStyle),
              ],
            ),
              ScrollList( value: storyValues, category: 'Fitness',),
          
          ],
        ),
      ):CategoryPage(storyValues: storyValues,),
    );
  }
}