import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voting_app/data/my_user.dart';
import 'package:flutter_voting_app/my_theme.dart';
import 'package:flutter_voting_app/user/vote_screen.dart';

import '../data/auth_helper.dart';

class UserScreen extends StatelessWidget {
  static String ROUTE_NAME = 'user_screen';
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as MyUser ;
    return Scaffold(
      backgroundColor: MyThemeData.background,
      appBar:AppBar(
        backgroundColor: MyThemeData.dark_blue,
        centerTitle: true,
        title: Row(
          children: [
            Text('User Screen',
              style: TextStyle(
                  color: MyThemeData.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold
              ),
            ),
            Spacer(),
            InkWell(
                onTap: (){
                  AuthHelper.currentUser = null;
                  Navigator.pop(context);
                },
                child: Icon(Icons.logout))
          ],
        ),
      ) ,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.05,vertical:MediaQuery.of(context).size.height*0.09 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                ClipRRect(
                  child: Image.network('https://flyclipart.com/thumb2/person-round-png-icon-free-download-137544.png',
                    width: 80,
                    height: 80,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                Text('${args.email}',
                  style: TextStyle(
                    color: MyThemeData.dark_blue,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.09,),
            ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                    backgroundColor: MaterialStateProperty.all(MyThemeData.dark_blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: MyThemeData.dark_blue)
                        )
                    )
                ),
                onPressed: (){
                  Navigator.of(context).pushNamed(VoteScreen.ROUTE_NAME);
                },
                child: Text('VOTE ',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: MyThemeData.white
                  ),
                )
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.08,),
          ],
        ),
      ),
    );
  }
}
