import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voting_app/admin/admin_screen.dart';
import 'package:flutter_voting_app/admin/vote_settings.dart';
import 'package:flutter_voting_app/login/login_screen.dart';
import 'package:flutter_voting_app/register/register_screen.dart';
import 'package:flutter_voting_app/user/user_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false ,
      initialRoute: AdminScreen.ROUTE_NAME,
      routes: {
        LoginScreen.ROUTE_NAME : (context) => LoginScreen(),
        RegisterScreen.ROUTE_NAME : (context) => RegisterScreen(),
        AdminScreen.ROUTE_NAME : (context) => AdminScreen(),
        VoteSettings.ROUTE_NAME : (context) => VoteSettings(),
        UserScreen.ROUTE_NAME : (context) => UserScreen(),


      },
    );
  }
}


