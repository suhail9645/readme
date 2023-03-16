import 'package:hive_flutter/hive_flutter.dart';
part 'model_favorite.g.dart';

@HiveType(typeId: 2)
class Favorite {
  Favorite(
    this.favoriteId,
  );
  @HiveField(0)
  final int favoriteId;
   @HiveField(1)
   int? id;
  
}

