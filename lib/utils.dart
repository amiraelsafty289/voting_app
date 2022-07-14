import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voting_app/admin/candidate_screen.dart';
import 'package:flutter_voting_app/data/firebase_utils.dart';
import 'package:flutter_voting_app/my_theme.dart';
import 'package:flutter_voting_app/user/user_screen.dart';
import 'package:flutter_voting_app/user/vote_screen.dart';

bool isValidEmail(String email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}
void showMessage(String message , BuildContext context){
  showDialog(
      context: context,
      builder: (buildContext){
        return AlertDialog(
          backgroundColor: MyThemeData.gray,
          content: Text(message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MyThemeData.dark_blue,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('OK',
                  style: TextStyle(
                    color: MyThemeData.dark_blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
            ),
          ],
        );
      }
  );
}

void showVoteSuccessfullyMessage(String message , BuildContext context){
  showDialog(
      context: context,
      builder: (buildContext){
        return AlertDialog(
          backgroundColor: MyThemeData.white,
          content: Text(message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MyThemeData.dark_blue,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.of(context).popUntil((route) => route.settings.name == UserScreen.ROUTE_NAME);
                },
                child: Text('OK',
                  style: TextStyle(
                    color: MyThemeData.dark_blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
            ),
          ],
        );
      }
  );
}

void showVoteMessage(String message , BuildContext context , Function onYesClick){
  showDialog(
      context: context,
      builder: (buildContext){
        return AlertDialog(
          backgroundColor: MyThemeData.white,
          content: Text(message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MyThemeData.dark_blue,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                      backgroundColor: MaterialStateProperty.all(MyThemeData.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: MyThemeData.dark_blue)
                          )
                      )
                  ),
                  onPressed: (){
                    onYesClick();
                  },
                  child: Text('Yes',
                    style: TextStyle(
                      color: MyThemeData.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                      backgroundColor: MaterialStateProperty.all(MyThemeData.orange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: MyThemeData.dark_blue)
                          )
                      )
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('No',
                    style: TextStyle(
                      color: MyThemeData.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }
  );
}

void showLoading(BuildContext context){
  showDialog(
      context: context,
      builder: (buildContext){
        return AlertDialog(
          backgroundColor: MyThemeData.gray,
          content: Row(
            children: [
              CircularProgressIndicator(color: MyThemeData.dark_blue,),
              SizedBox(width: 12,),
              Text('Loading...',
                style: TextStyle(
                  color: MyThemeData.dark_blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      }
  );
}

void hideLoading(BuildContext context){
  Navigator.pop(context);
}

