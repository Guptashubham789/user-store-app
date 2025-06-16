import 'package:flutter/material.dart';
import 'package:store_app/controllers/auth_controller.dart';

class AccountScreen extends StatelessWidget {
   AccountScreen({super.key});
  final AuthController authController=AuthController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            authController.signOutUser(context: context);
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text("Accunts Screen"),
      ),
    );
  }
}
