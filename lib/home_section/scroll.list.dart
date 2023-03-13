import 'package:flutter/material.dart';
import 'package:read_me/model/model_story.dart';

class ScrollList extends StatelessWidget {
  const ScrollList({super.key, required this.category});
  final ValueNotifier<List<Story>> category;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: category,
      builder: (context, value, child) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: value
              .map((e) => Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 70,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color:const Color.fromARGB(255, 22, 22, 23)
                                .withOpacity(0.5),
                            
                            blurRadius: 3,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          e.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )))
              .toList(),
        ),
      ),
    );
  }
}
