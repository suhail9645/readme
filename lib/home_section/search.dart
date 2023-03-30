import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:read_me/model/model_story.dart';
import 'package:read_me/read_section/read.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
    required this.story,
  });
  final Box<Story> story;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Variables.searchvalue,
      builder: (context, value, child) {
        List<Story> result = [];
        for (var element in story.values) {
          if (element.storyname.toLowerCase().contains(value.toLowerCase())) {
            result.add(element);
          }
        }
        return result.isNotEmpty
            ? ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReadPage(story: result[index]),
                      ));
                    },
                    title: Text(
                      result[index].storyname,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text('by ${result[index].authorname}',
                        style: Variables.sStyle),
                    leading: ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: Image.network(result[index].image,
      width: 45.0,
      height: 120,
      fit: BoxFit.cover,
    ),
  ),
                  );
                },
              )
            : Center(
                child: Column(
                  children: [
                    Lottie.asset('assets/animations/68758-search.json',
                        width: 200, height: 200),
                    Text(
                      'No result',
                      style: Variables.mStyle,
                    )
                  ],
                ),
              );
      },
    );
  }
}
