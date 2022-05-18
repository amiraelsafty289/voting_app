import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voting_app/my_theme.dart';

class UserScreen extends StatelessWidget {
  static String ROUTE_NAME = 'user_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.background,
      appBar:AppBar(
        backgroundColor: MyThemeData.dark_blue,
        centerTitle: true,
        title: Text('Vote Chain',
          style: TextStyle(
              color: MyThemeData.white,
              fontSize: 35,
              fontWeight: FontWeight.bold
          ),
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
                  child: Image.asset('assets/images/login_image.png',
                    width: 80,
                    height: 80,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                Text('User@gmail.com',
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
                },
                child: Text('RESULT',
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
