import 'package:flutter/material.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:read_me/read_section/read.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Variables.category,
        builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Text(
                    Variables.category.value.value[0].category,
                    style: Variables.mStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: value.value.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 140,
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReadPage(story: value.value[index]),
                          ));
                        },
                        child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 7, 13, 51)
                                    .withOpacity(1),
                                blurRadius: 3,
                                offset: const Offset(0, 4),
                              )
                            ]),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  image: NetworkImage(
                                    value.value[index].image,
                                  ),
                                  fit: BoxFit.cover,
                                ))),
                      );
                    },
                  ),
                ),
              ],
            ));
  }
}
