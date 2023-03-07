import 'dart:io';

class Story {
  // final File image;
  final int? id;
  final String storyname;
  final String authorname;
   final String image;
  final String category;
  final String story;

  Story(
      {required this.storyname,
      required this.authorname,
      required this.story,
      required this.category,
      required this.image,
      this.id});
toJson(){
  return{'StoryName':storyname,'AuthorName':authorname,'Story':story,'Catagory':category,'image':image};
}
      
}
