import 'package:flutter/material.dart';
import 'package:flutter_voting_app/data/voting.dart';
import 'package:flutter_voting_app/my_theme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../data/candidate.dart';

class ResultItem extends StatelessWidget {
  Candidate candidate;
  Voting voting;
  ResultItem({required this.candidate, required this.voting});
  @override
  Widget build(BuildContext context) {
   double result = candidate.votersCounter / voting.totalVoters  ;
   ///todo we have to fix result item
   return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              '${candidate.name}',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: MyThemeData.dark_blue),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          LinearPercentIndicator(
            alignment: MainAxisAlignment.center,
            width: 280.0,
            animation: true,
            lineHeight: 24.0,
            percent: result,
            center: Text("${(result*100).toStringAsFixed(2)}%",
              style: TextStyle(
                color: MyThemeData.white,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            backgroundColor: MyThemeData.gray,
            progressColor: MyThemeData.dark_blue,
          ),
        ],
      ),
    );
  }
}
