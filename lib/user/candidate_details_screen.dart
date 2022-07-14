import 'package:flutter/material.dart';
import 'package:flutter_voting_app/data/candidate.dart';
import 'package:flutter_voting_app/my_theme.dart';

class CandidateDetailsScreen extends StatelessWidget{
  static String ROUTE_NAME = 'candidate__details_screen';
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Candidate ;
    return Scaffold(
      backgroundColor: MyThemeData.background,
      appBar:AppBar(
        backgroundColor: MyThemeData.dark_blue,
        centerTitle: true,
        title: Text('Candidate Details Screen',
          style: TextStyle(
              color: MyThemeData.white,
              fontSize: 22,
              fontWeight: FontWeight.bold
          ),
        ),
      ) ,
      body: Container(
        margin: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 30,
              child: Image.asset('assets/images/login_image.png'),
            ),
            SizedBox(height: 25,),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: MyThemeData.white,
                border: Border.all(color: MyThemeData.gray , width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${args.name}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: MyThemeData.dark_blue
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text('Age: ${args.age}',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: MyThemeData.dark_blue
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text('Description: ${args.description}',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: MyThemeData.dark_blue
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
