import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voting_app/data/voting.dart';
import 'package:flutter_voting_app/data/firebase_utils.dart';
import 'package:flutter_voting_app/my_theme.dart';
import 'package:flutter_voting_app/user/vote_item.dart';

class VoteScreen extends StatefulWidget {
  static String ROUTE_NAME = 'vote_screen';

  @override
  State<VoteScreen> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
Future<QuerySnapshot> votingFuture = getAllVotings();
List<Voting> votingList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.background,
      appBar:AppBar(
        backgroundColor: MyThemeData.dark_blue,
        centerTitle: true,
        title: Text('Vote Screen',
          style: TextStyle(
              color: MyThemeData.white,
              fontSize: 35,
              fontWeight: FontWeight.bold
          ),
        ),
      ) ,
      body: FutureBuilder<QuerySnapshot>(
        future: votingFuture,
        builder: (context , snapShot){
          if(snapShot.hasData){
            votingList = snapShot.data!.docs.map((doc){
              Voting voting = Voting.fromJson(doc.data() as Map<String , dynamic>);
              voting.voteId = doc.id ;
              return voting ;
            }).toList();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  Text('List Of Vote Right Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize:22 ,
                        fontWeight:FontWeight.bold ,
                        color: MyThemeData.dark_blue
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height*0.02,),
                    // vertical: MediaQuery.of(context).size.height*0.15),
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.05),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color:MyThemeData.dark_blue,width: 3 ),
                    ),
                    child: ListView.builder(
                        itemCount: votingList.length,
                        itemBuilder: (context , index){
                          return VoteItem(voting: votingList[index],);
                        }
                    ),
                  ),

                ],
              ),
            );
          }else if(snapShot.hasError){
            return Center(child: Text('Error while loading elections'));
          } else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

