import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/provider/user_provider.dart';
import 'package:store_app/views/screens/authentication_screen/login_screen.dart';
import 'package:store_app/views/screens/main_screen.dart';

void main() {
  //Run th flutter app wraped in a ProviderScrope for manage
  runApp(ProviderScope(child: const MyApp()));
}

//Root widget of the application a cosummerWidget to consume state change
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

//Method to check the token and set the user data if available
  Future<void> _checkTokenAndSetUser(WidgetRef ref)async{
    //Obtain an nstance of sharedPreference for local data storage
    SharedPreferences preferences=await SharedPreferences.getInstance();
    //Retrive the authentication token and user data store locally
    String? token=preferences.getString('auth_token');
    String? userJson=preferences.getString('user');
    //if both token and user data are availble update the user state
    if(token!=null && userJson!=null){
      ref.read(userProvider.notifier).setUser(userJson);
    }else{
      ref.read(userProvider.notifier).signOut();
    }
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store App',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
          future: _checkTokenAndSetUser(ref),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );

            }
            final user=ref.watch(userProvider);
            return user!=null?MainScreen():LoginScreen();
          }),
    );
  }
}
