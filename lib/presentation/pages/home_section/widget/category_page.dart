import 'package:flutter/material.dart';
import 'package:read_me/domain/repository/other.dart';
import 'package:read_me/presentation/pages/home_section/variables.dart';
import '../../../../domain/model/model_story.dart';
import '../../read_section/read.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    super.key,
    required this.storyValues,
    required this.categoryName,
  });
  final List<Story> storyValues;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    List<Story> storyList =
        OtherAllFunctions.sepratingStory(storyValues, categoryName);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
            storyList.first.category,
            style: Variables.mStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: storyList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 140,
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReadPage(
                      story: storyList[index],
                    ),
                  ));
                },
                child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color:
                            const Color.fromARGB(255, 7, 13, 51).withOpacity(1),
                        blurRadius: 3,
                        offset: const Offset(0, 4),
                      )
                    ]),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                            image: NetworkImage(
                              storyList[index].image,
                            ),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return ColoredBox(
                                color: Colors.black12,
                                child: Center(
                                  child: Text(
                                    storyList[index].storyname,
                                    style: Variables.sStyle,
                                  ),
                                ),
                              );
                            }))),
              );
            },
          ),
        ),
      ],
    );
  }
}
