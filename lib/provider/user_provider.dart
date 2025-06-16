import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

class UserProvider extends StateNotifier<User?>{
  // contructore initalizing with default User Object
  ///purpose: manage the state of the user object allowing updates
  UserProvider(): super(
    User(
        id: '',
        fullName: '',
        email: '',
        state: '',
        city: '',
        locality: '',
        password: '',
        token: ''));

  ///Geter method to extract value from an Object

  User? get user=>state;

  //method to set user from Json
  //purpose : updates he user state base on json string respresentation of user onect

  void setUser(String userJson){
    state=User.fromJson(userJson);
  }
  //Method to clear user state
  void signOut(){
    state=null;
  }
}
final userProvider = StateNotifierProvider<UserProvider, User?>((ref)=>
    UserProvider());
