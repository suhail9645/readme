import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:read_me/data/models/failure_model.dart';
import 'package:read_me/data/repository/hive_operation.dart';
import '../../domain/repository/firebase_auth.dart';
import 'firestore_user.dart';

class FirebaseUserOperationsimp extends FirebaseUserOperations {
  @override
  Future<Either<Failure,bool>> checkUser(String email, String password) async {
    try{
    final auth = FirebaseAuth.instance;
    UserCredential user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    if (auth.currentUser != null) {
      final data = await FireStoreUserImp().getAllUserDetails(user.user!.uid);
      await HiveUserProfileImp().addProfileIntoHIve(data!);
      await HiveOperationsImp().addUserDatailes('user');
      return right(true);
    }
    }catch(e){
      return left(Failure(error: e.toString()));
    }
    return left(Failure(error: 'Something wrong'));
  }
}
