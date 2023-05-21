import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:read_me/main.dart';
import 'package:read_me/presentation/pages/profile_section/bloc/profile_bloc.dart';

import '../../../data/functions/functions.dart';
import '../../../domain/model/model_story.dart';
import '../home_section/variables.dart';
import '../read_section/read.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key, required this.favouriteStories});
  final List<Story> favouriteStories;
  @override
  Widget build(BuildContext context) {
    return favouriteStories.isNotEmpty
        ? ListView.builder(
            itemCount: favouriteStories.length,
            itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ReadPage(story: favouriteStories[index]),
                  ));
                },
                title: Text(
                  favouriteStories[index].storyname,
                  style: Variables.mStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  'by ${favouriteStories[index].authorname}',
                  style: Variables.sStyle,
                ),
                trailing: IconButton(
                    onPressed: () {
                      profileBodyBloc.add(DeleteFavouriteEvent(favorite: favouriteStories[index], context: context));                   // ClassFunctions.addFavorite(
                      //     favouriteStories[index], context);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    favouriteStories[index].image,
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
                )),
          )
        : Center(
            child: Column(children: [
              Lottie.asset('assets/animations/68758-search.json',
                  height: 200, width: 200),
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
  }
  // } else {
  //   return const Center(child: CircularProgressIndicator());
  // }
}
