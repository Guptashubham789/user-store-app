import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/global_variables.dart';
import 'package:store_app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/services/manage_http_response.dart';
import 'package:store_app/views/screens/authentication_screen/login_screen.dart';
import 'package:store_app/views/screens/main_screen.dart';
import 'package:store_app/provider/user_provider.dart';
final providerContainer=ProviderContainer();
class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body:
              user.toJson(), //Convert the user object to json for the req body
          headers: <String, String>{
            "Content-Type":
                "application/json; charset=UTF-8", //specify the context type as Json
          } //set the Headers for the req
          );
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()
            ));
            showSnackBar(context, "Account has been Created for you");
          });
    } catch (e) {}
  }

  ///signin users function
  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      UserProvider userProvider=UserProvider();
    http.Response response= await http.post(Uri.parse('$uri/api/signin'),
      body: jsonEncode({
        'email':email,//include the email in the request body.
        'password':password,//include the password in the req body.

      },
      ),
      headers: <String,String>{//the will set the headers
        'Content-Type':'application/json; charset=UTF-8',
      }
      );


      //hsndles the response using the manage httpResponse
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () async{

            //Access sharedPreferences for token and user data storage
            SharedPreferences preferences= await SharedPreferences.getInstance();

            //Extract the authentication token from the response body
            String token=jsonDecode(response.body)['token'];

            //Store the authentication token securely in SharedPreference
            await preferences.setString('auth_token', token);

            //Encode the user data recived from the backend as json
            final userJson=jsonEncode(jsonDecode(response.body)['user']);

            //update the application state with the user data using riverpod
           // providerContainer.read(userProvider.notifier).setUser(userJson);

            //store the data in sharedpreference for future use
            await preferences.setString('user', userJson);

            await preferences.setString('user', userJson);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainScreen()),
                    (route)=>false);
            showSnackBar(context, "Account has been login for you");
          });
    } catch (e) {
      print("Error : $e");
    }
  }

  //Signout
  Future<void> signOutUser({required context}) async{
    try{
      SharedPreferences preferences=await SharedPreferences.getInstance();
      //clear the token and user from SharedPreference
      await preferences.remove('auth_token');
      await preferences.remove('user');
      //clear the user state
      providerContainer.read(userProvider.notifier).signOut();
      //navigate the user back to the login screen
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){return LoginScreen();}), (route)=>false);

      showSnackBar(context, "signout successfully");
    }catch(e){
      showSnackBar(context, 'error signing out');
    }
  }
}
