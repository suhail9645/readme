import 'package:hive_flutter/adapters.dart';
import 'package:read_me/core/strings.dart';
import 'package:read_me/domain/model/model_story.dart';

import '../../domain/repository/story_hive.dart';

class StoryHiveOperationImp extends StoryHiveOperation{
  @override
  Future<List<Story>> getAllStoriesFromHive() async{
    List<Story>allStories=[];
    final storyDb=await Hive.openBox<Story>(storyHive);
    allStories.addAll(storyDb.values);
    return allStories;
      
  }

}