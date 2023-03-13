import 'package:hive_flutter/hive_flutter.dart';
part 'model_story.g.dart';

@HiveType(typeId: 1)
class Story {
  @HiveField(0)
   int? id;
  @HiveField(1)
  final String storyname;
  @HiveField(2)
  final String authorname;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final String category;
  @HiveField(5)
  final String story;

  Story(
      {required this.storyname,
      required this.authorname,
      required this.story,
      required this.category,
      required this.image,
      this.id});
  toJson() {
    return {
      'storyName': storyname,
      'authorName': authorname,
      'story': story,
      'category': category,
      'image': image
    };
  }
}
