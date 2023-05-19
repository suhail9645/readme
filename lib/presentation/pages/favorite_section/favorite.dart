import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../../data/functions/functions.dart';
import '../../../domain/model/model_story.dart';
import '../home_section/variables.dart';
import '../read_section/read.dart';
import '../widgets/widgets.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.appBackground,
      appBar: AppBar(
        backgroundColor: Variables.mColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Favorite',
              style: Variables.mStyle,
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(
              Icons.favorite,
              color: Colors.red,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: Hive.openBox<Story>('story'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final storyDb = Hive.box<Story>('story');
                return ValueListenableBuilder(
                  valueListenable: storyDb.listenable(),
                  builder: (context, value, child) {
                    List<Story> favoriteStory =
                        ClassFunctions.favoriteGet(value);
                    return favoriteStory.isNotEmpty
                        ? ListView.builder(
                            itemCount: favoriteStory.length,
                            itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ReadPage(story: favoriteStory[index]),
                                ));
                              },
                              title: Text(
                                favoriteStory[index].storyname,
                                style: Variables.mStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                'by ${favoriteStory[index].authorname}',
                                style: Variables.sStyle,
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => CustomAlert(
                                        content:
                                            'Deleting this story from favorite',
                                        context: context,
                                        onPress: () {
                                          ClassFunctions.addFavorite(
                                              favoriteStory[index], context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  favoriteStory[index].image,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(),
                                        ));
                                  },
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Column(children: [
                              Lottie.asset('assets/animations/empty_box.json'),
                              Text(
                                'NO ITEMS',
                                style: Variables.mStyle,
                              ),
                              Text(
                                'No favorite stories to show',
                                style: Variables.sStyle,
                              )
                            ]),
                          );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    'Please wait',
                    style: Variables.mStyle,
                  ),
                );
              }
            }),
      ),
      bottomNavigationBar: const CustomBottom(),
    );
  }
}
