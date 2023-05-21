import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:read_me/data/repository/hive_operation.dart';
import 'package:read_me/main.dart';
import '../../../data/functions/functions.dart';
import '../../../domain/model/model_story.dart';
import '../home_section/variables.dart';
import '../read_section/read.dart';
import '../widgets/widgets.dart';
import 'bloc/favourite_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    favouriteBloc.add(FavoriteInitialEvent());
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
          child: BlocConsumer<FavouriteBloc, FavouriteState>(
        bloc: favouriteBloc,
        listener: (context, state) {},
        builder: (context, state) {
          final successState = state as FavouriteInitial;

          return successState.favouriteStories.isNotEmpty
              ? ListView.builder(
                  itemCount: successState.favouriteStories.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReadPage(
                            story: successState.favouriteStories[index]),
                      ));
                    },
                    title: Text(
                      successState.favouriteStories[index].storyname,
                      style: Variables.mStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      'by ${successState.favouriteStories[index].authorname}',
                      style: Variables.sStyle,
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => CustomAlert(
                              content: 'Deleting this story from favorite',
                              context: context,
                              onPress: () {
                                favouriteBloc.add(FavouriteRemoveEvent(
                                    successState.favouriteStories[index],
                                    context));
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
                        successState.favouriteStories[index].image,
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
      )),
      // } else {
      //   return Center(
      //     child: Text(
      //       'Please wait',
      //       style: Variables.mStyle,
      //     ),
      //   );
      // }

      bottomNavigationBar: const CustomBottom(),
    );
  }
}
