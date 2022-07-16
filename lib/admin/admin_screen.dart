import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voting_app/admin/vote_settings.dart';
import 'package:flutter_voting_app/data/auth_helper.dart';
import 'package:flutter_voting_app/my_theme.dart';

import '../auth/register/register_screen.dart';

class AdminScreen extends StatelessWidget {
  static String ROUTE_NAME = 'admin';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.background,
      appBar: AppBar(
        backgroundColor: MyThemeData.dark_blue,
        centerTitle: true,
        title: Row(
          children: [
            Text('Admin Screen',
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
      ),
      body: Container(
        width: MediaQuery.of(context).size.width*0.8,
        height: MediaQuery.of(context).size.height*0.5,
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height*0.05,
            vertical: MediaQuery.of(context).size.height*0.15),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color:MyThemeData.dark_blue,width: 3 )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                  Navigator.of(context).pushNamed(VoteSettingsScreen.ROUTE_NAME);
                  },
                child: Text('VOTE SETTINGS',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: MyThemeData.white
                  ),
                )
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.08,),
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
                  Navigator.of(context).pushNamed(RegisterScreen.ROUTE_NAME);
                },
                child: Text('USERS SETTINGS',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: MyThemeData.white
                  ),
                )
            ),

          ],
        ),
      ),
    );
  }
}
