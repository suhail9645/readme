import 'package:firebase_auth/firebase_auth.dart';
import 'package:read_me/data/repository/hive_operation.dart';
import '../../domain/repository/firebase_auth.dart';
import 'firestore_user.dart';

class FirebaseUserOperationsimp extends FirebaseUserOperations {
  @override
  Future<bool> checkUser(String email, String password) async {
    final auth = FirebaseAuth.instance;
    UserCredential user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    if (auth.currentUser != null) {
      final data = await FireStoreUserImp().getAllUserDetails(user.user!.uid);
      await HiveUserProfileImp().addProfileIntoHIve(data!);
      await HiveOperationsImp().addUserDatailes('user');
      return true;
    }
    return false;
  }
}
