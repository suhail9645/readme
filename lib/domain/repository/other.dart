import '../model/model_story.dart';

class OtherAllFunctions{
  static List<Story> sepratingStory(List<Story>allStories, String category) {
  
    List<Story> categoryStory = [];
    for (var element in allStories) {
      if (element.category == category) {
        categoryStory.add(element);
      }
    }
    return categoryStory;
  }

}