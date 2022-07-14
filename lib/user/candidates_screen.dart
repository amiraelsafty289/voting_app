import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voting_app/data/candidate.dart';
import 'package:flutter_voting_app/data/voting.dart';
import 'package:flutter_voting_app/data/firebase_utils.dart';
import 'package:flutter_voting_app/my_theme.dart';
import 'package:flutter_voting_app/user/candidates_item.dart';

class CandidatesScreen extends StatelessWidget {
  static String ROUTE_NAME = 'candidates';
  List<Candidate> candidateList = [];

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Voting;
    return Scaffold(
        backgroundColor: MyThemeData.background,
        appBar: AppBar(
          backgroundColor: MyThemeData.dark_blue,
          centerTitle: true,
          title: Text(
            'Candidates Screen',
            style: TextStyle(
                color: MyThemeData.white,
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: getAllCandidates(args.voteId!),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              candidateList = snapShot.data!.docs.map((doc) {
                Candidate candidate =
                    Candidate.fromJson(doc.data() as Map<String, dynamic>);
                candidate.candidateId = doc.id; // check
                return candidate;
              }).toList();
              return  Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: candidateList.length,
                        itemBuilder: (context, index) {
                          return CandidateItem(
                            candidate: candidateList[index],
                            voting: args,
                          );
                        }),
                  ),
                ],
              );
            } else if (snapShot.hasError) {
              return Center(child: Text('Error while loading candidates'));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
