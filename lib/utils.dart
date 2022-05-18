import 'package:flutter/material.dart';
import 'package:flutter_voting_app/my_theme.dart';

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

