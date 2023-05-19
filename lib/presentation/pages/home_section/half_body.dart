
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:read_me/presentation/pages/home_section/scroll.list.dart';
import '../../../domain/model/model_story.dart';
import 'category_page.dart';
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
              ScrollList( value: storyValues, category: 'Top 10',),
                 Row(
              children: [Image.asset('assets/new.png',height: 30,),
                const SizedBox(
                  width: 3,
                ),
                  Text('Newly published',style: Variables.mStyle),
              ],
            ),
              ScrollList( value: storyValues, category: 'Newly published',),
          
          ],
        ),
      ):CategoryPage(storyValues: storyValues,),
    );
  }
}