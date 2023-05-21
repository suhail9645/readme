import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:read_me/domain/model/model_story.dart';

import '../../core/strings.dart';
import '../../domain/repository/firebase_firestore.dart';

class FirebaseStoryOperationsimp extends FirebaseStoryOperations {
  @override
  Future<Box<Story>> getAllStory() async {
    final storyDb = await Hive.openBox<Story>(storyHive);
    final Query query = FirebaseFirestore.instance.collection('story');
    final QuerySnapshot querySnapshot = await query.get();

    for (int element = 0; element < querySnapshot.docs.length; element++) {
      Map<String, dynamic> data =
          querySnapshot.docs[element].data() as Map<String, dynamic>;

      final story = Story(
        storyname: data['storyName'],
        authorname: data['authorName'],
        story: data['story'],
        category: data['category'],
        image: data['image'],
        firUid: querySnapshot.docs[element].id,
        isFavorite: false,
      );
      bool flag = true;
      for (var element in storyDb.values) {
        if (element.firUid == story.firUid) {
          flag = false;
        }
      }
      if (flag) {
        story.id = await storyDb.add(story);
        await storyDb.put(story.id, story);
      }
    }
    return storyDb;
  }
}
