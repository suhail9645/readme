import 'package:read_me/domain/model/model_story.dart';

abstract class StoryHiveOperation{
  Future<List<Story>>getAllStoriesFromHive();
}