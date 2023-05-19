import 'package:hive_flutter/hive_flutter.dart';
part 'model_user.g.dart';
@HiveType(typeId: 4)
class UserData {
  @HiveField(0)
  final String userName;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String? imageUrl;
  @HiveField(3)
  final String uid;
  UserData(
      {required this.uid,
      required this.userName,
      required this.fullName,
      required this.imageUrl});
}
