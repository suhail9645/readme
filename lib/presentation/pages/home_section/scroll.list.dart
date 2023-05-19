import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/functions/functions.dart';
import '../../../domain/model/model_story.dart';
import '../read_section/read.dart';
import 'variables.dart';

class ScrollList extends StatelessWidget {
  const ScrollList({
    super.key,
   
    required this.value, required this.category,
  });
  
  final Box<Story> value;
  final String category;
  @override
  Widget build(BuildContext context) {
    List<Story> categoryStory=ClassFunctions.sepratingStory(value,category);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoryStory
            .map((e) => Padding(
                padding: const EdgeInsets.all(6.0),
                child: GestureDetector(
                  onTap: () async {
                 
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReadPage(
                        story: e,
                      ),
                    ),
                    );
                  },
                  child: Container(
                    width: 70,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 22, 22, 23)
                              .withOpacity(0.5),
                          blurRadius: 3,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(e.image, fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                        return ColoredBox(
                          color: Colors.black12,
                          child: Center(
                            child: Text(
                              e.storyname,
                              style: Variables.sStyle,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                )))
            .toList(),
      ),
    );
  }
}