import 'package:flutter/material.dart';
import 'package:flutter_voting_app/data/voting.dart';
import 'package:flutter_voting_app/my_theme.dart';
import 'package:flutter_voting_app/user/candidates_screen.dart';
import 'package:flutter_voting_app/user/result_screen.dart';

class VoteItem extends StatelessWidget {
  Voting voting;
  VoteItem({required this.voting});
  @override
  Widget build(BuildContext context) {
    DateTime endDate = DateTime.fromMillisecondsSinceEpoch(voting.endDate);
    return InkWell(
      onTap: () {
        if(DateTime.now().compareTo(endDate) == -1){
          Navigator.of(context)
              .pushNamed(CandidatesScreen.ROUTE_NAME, arguments: voting);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.15,
        margin: EdgeInsets.only(bottom: 14),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyThemeData.dark_blue, width: 2)),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    child: Image.network(
                      'https://w7.pngwing.com/pngs/760/31/png-transparent-sussex-voting-election-others-hand-logo-union-thumbnail.png',
                      width: 70,
                      height: 70,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  Text(
                    '${voting.voteName}',
                    style: TextStyle(
                        color: MyThemeData.dark_blue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  DateTime.now().compareTo(endDate) == -1?SizedBox():ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                          backgroundColor:
                              MaterialStateProperty.all(MyThemeData.dark_blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                          color: MyThemeData.dark_blue)))),
                      onPressed: () {
                        Navigator.of(context).pushNamed(ResultScreen.ROUTE_NAME,arguments: voting);
                      },
                      child: Text(
                        'RESULT',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: MyThemeData.white),
                      )),
                ],
              ),
            ),
            Container(
                child: DateTime.now().compareTo(endDate) == 1  ? Text("expired", style: TextStyle(fontSize: 18 ,color: Colors.red, fontWeight: FontWeight.bold),) : SizedBox()),
          ],
        ),
      ),
    );
  }
}
