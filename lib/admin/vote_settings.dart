import 'package:flutter/material.dart';
import 'package:flutter_voting_app/admin/candidate_screen.dart';
import 'package:flutter_voting_app/admin/create_votings.dart';
import 'package:flutter_voting_app/admin/voters_screen.dart';
import 'package:flutter_voting_app/my_theme.dart';

class VoteSettingsScreen extends StatelessWidget {
  static String ROUTE_NAME = 'vote_settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.background,
      appBar: AppBar(
        backgroundColor: MyThemeData.dark_blue,
        centerTitle: true,
        title: Text('Vote Settings',
          style: TextStyle(
              color: MyThemeData.white,
              fontSize: 35,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.09 , vertical: MediaQuery.of(context).size.height*0.20 ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right:MediaQuery.of(context).size.height*0.03 ),
              decoration: BoxDecoration(
                color: MyThemeData.dark_blue,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(VotingScreen.ROUTE_NAME);
                      },
                      icon:Icon(Icons.add,color: MyThemeData.white,)
                  ),
                  Text('CREATE',
                    style: TextStyle(
                      color: MyThemeData.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.09,),
            Container(
              padding: EdgeInsets.only(right:MediaQuery.of(context).size.height*0.03 ),
              decoration: BoxDecoration(
                color: MyThemeData.dark_blue,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(VotersScreen.ROUTE_NAME);
                      },
                      icon:Icon(Icons.add,color: MyThemeData.white,)
                  ),
                  Text('VOTERS',
                    style: TextStyle(
                        color: MyThemeData.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.09,),
            Container(
              padding: EdgeInsets.only(right:MediaQuery.of(context).size.height*0.03 ),
              decoration: BoxDecoration(
                color: MyThemeData.dark_blue,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(CandidateScreen.ROUTE_NAME);
                      },
                      icon:Icon(Icons.add,color: MyThemeData.white,)
                  ),
                  Text('CANDIDATES',
                    style: TextStyle(
                        color: MyThemeData.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
