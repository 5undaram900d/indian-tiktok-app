
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/Models/user.dart';
import 'package:tiktok_clone/constants.dart';

class SearcController extends GetxController {
  final Rx<List<User>> _searchUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchUsers.value;

  searchUser(String typedUser) async{
    _searchUsers.bindStream(fireStore.collection('users').where('name', isGreaterThanOrEqualTo: typedUser).snapshots().map((QuerySnapshot query){
      List<User> retVal = [];
      for(var element in query.docs) {
        retVal.add(User.fromSnap(element));
      }
      return retVal;
    }));
  }

}