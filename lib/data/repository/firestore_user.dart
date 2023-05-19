import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_me/domain/repository/firebase_firestore.dart';
import '../../presentation/pages/register_section/register_functions.dart';

class FireStoreUserImp extends FireStoreUserOperations {
  @override
  Future<QueryDocumentSnapshot?> getAllUserDetails(String uid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final QuerySnapshot userDatas = await firestore.collection('user').get();

    for (var element in userDatas.docs) {
      if (element.id == uid) {
        
        await RegisterFunction.getUserDetailesInValueNotifier();
        return element;
      }
    }
    return null;
  }
}