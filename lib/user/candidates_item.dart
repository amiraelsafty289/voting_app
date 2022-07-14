import 'package:flutter/material.dart';
import 'package:flutter_voting_app/data/candidate.dart';
import 'package:flutter_voting_app/data/firebase_utils.dart';
import 'package:flutter_voting_app/data/voting.dart';
import 'package:flutter_voting_app/my_theme.dart';
import 'package:flutter_voting_app/user/candidate_details_screen.dart';
import 'package:flutter_voting_app/utils.dart';

class CandidateItem extends StatelessWidget {
Candidate candidate ;
 Voting voting ;
CandidateItem({required this.candidate,required this.voting });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(CandidateDetailsScreen.ROUTE_NAME , arguments: candidate);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: MyThemeData.gray , width: 2),
        ),
        child: Column(
          children: [
            Row(
              children: [
                // candidate.image
                Image.asset('assets/images/login_image.png',
                  width: 70,
                  height: 70,
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name : ${candidate.name}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: MyThemeData.dark_blue
                      ),
                    ),
                    Text('Age : ${candidate.age}',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: MyThemeData.dark_blue
                      ),
                    )
                  ],
                ),
                Spacer(),
                ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                        backgroundColor: MaterialStateProperty.all(MyThemeData.dark_blue),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: MyThemeData.dark_blue)
                            )
                        )
                    ),
                    onPressed: (){
                      showVoteMessage('Are you sure you want to vote this Person ', context,(){
                        print('Amira: before ${voting.totalVoters}');
                        print('Amira:before ${candidate.votersCounter}');
                        vote(voting, candidate,context);
                        print('Amira: after ${voting.totalVoters}');
                        print('Amira: after ${candidate.votersCounter}');
                        showVoteSuccessfullyMessage('You have voted for ${candidate.name} successfully ', context);
                      } );

                    },
                    child: Text('Vote',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: MyThemeData.white
                    ),
                    )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
