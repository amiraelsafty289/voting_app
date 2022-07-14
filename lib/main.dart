import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voting_app/admin/admin_screen.dart';
import 'package:flutter_voting_app/admin/candidate_screen.dart';
import 'package:flutter_voting_app/admin/create_votings.dart';
import 'package:flutter_voting_app/admin/vote_settings.dart';
import 'package:flutter_voting_app/admin/voters_screen.dart';
import 'package:flutter_voting_app/user/candidate_details_screen.dart';
import 'package:flutter_voting_app/user/candidates_screen.dart';
import 'package:flutter_voting_app/user/result_screen.dart';
import 'package:flutter_voting_app/user/user_screen.dart';
import 'package:flutter_voting_app/user/vote_screen.dart';

import 'auth/login/login_screen.dart';
import 'auth/register/register_screen.dart';

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
      initialRoute: LoginScreen.ROUTE_NAME,
      routes: {
        LoginScreen.ROUTE_NAME : (context) => LoginScreen(),
        RegisterScreen.ROUTE_NAME : (context) => RegisterScreen(),
        AdminScreen.ROUTE_NAME : (context) => AdminScreen(),
        VoteSettingsScreen.ROUTE_NAME : (context) => VoteSettingsScreen(),
        UserScreen.ROUTE_NAME : (context) => UserScreen(),
        VotingScreen.ROUTE_NAME : (context) => VotingScreen(),
        CandidatesScreen.ROUTE_NAME : (context) => CandidatesScreen(),
        VotersScreen.ROUTE_NAME : (context) => VotersScreen(),
        VoteScreen.ROUTE_NAME : (context) => VoteScreen(),
        CandidateScreen.ROUTE_NAME : (context) => CandidateScreen(),
        CandidateDetailsScreen.ROUTE_NAME : (context) => CandidateDetailsScreen(),
        ResultScreen.ROUTE_NAME : (context) => ResultScreen(),
      },
    );
  }
}


