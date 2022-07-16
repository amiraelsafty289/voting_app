import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voting_app/data/auth_helper.dart';
import 'package:flutter_voting_app/data/candidate.dart';
import 'package:flutter_voting_app/data/voting.dart';
import 'package:flutter_voting_app/data/my_user.dart';
import 'package:flutter_voting_app/utils.dart';

Future<void> addUserToFireStore(MyUser user) {
  return MyUser.withConverter().doc(user.id).set(user);
}

Future<bool> createVoting(String voteId, String voteName, DateTime startDate,
    DateTime endDate, BuildContext context) async {
  // law id mawgood hyd5l wa7d tany
  bool isExist = await checkId(voteId);
  if (isExist) {
    showMessage('Please enter another vote Id', context);
    return false;
  }
  DocumentReference docRef =
      FirebaseFirestore.instance.collection('voting').doc(voteId);
  docRef.set({
    'vote_id': voteId,
    'vote_name': voteName,
    'start_date': startDate.millisecondsSinceEpoch,
    'end_date': endDate.millisecondsSinceEpoch,
    'total_voters': 0
  });
  return true;
}

Future<bool> checkId(String id) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('voting').get();
  bool isExist = false;
  for (var element in snapshot.docs) {
    if (element.id == id) {
      isExist = true;
    }
  }
  return isExist;
}

addVoter(String voteId, String email, BuildContext context) async {
  // law id msh mawgood d5l wa7d tany gded
  bool isExist = await checkId(voteId);
  if (!isExist) {
    showMessage('Please enter another voter id', context);
    return;
  }
  FirebaseFirestore.instance
      .collection('voting')
      .doc(voteId)
      .collection('voters')
      .doc()
      .set({
    'email': email,
    'is_voted': false,
  }).then((value) {
    showMessage('Voters added Successfully', context);
  }).onError((error, stackTrace) {
    print(error.toString());
    showMessage('Try again to added new voter', context);
  });
}

Future<void> addCandidate(String voteId, String name, String age, String description,
    BuildContext context, String candidateId) async {
  // law id fady yrou7 yd5l wa7d tany
  bool isExist = await checkId(voteId);
  if (!isExist) {
    showMessage('Please enter another vote id', context);
    return;
  }
  DocumentReference doc = FirebaseFirestore.instance
      .collection('voting')
      .doc(voteId)
      .collection('candidates')
      .doc();
  return doc.set({
    'name': name,
    'age': age,
    'description': description,
    'candidate_id': doc.id,
    'image': '1233',
    'voters_counter': 0
  });
}

Future<List<Voting>> getAllVotings() async {
  String email = AuthHelper.currentUser!.email;
  List<Voting> votings = [];
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('voting').get();

  /// ana gebt kol votes
  for (var vote in querySnapshot.docs) {
    /// el vote howa kol doc mawgod gowa el fb
    QuerySnapshot votersQuerySnapshot = await FirebaseFirestore.instance
        .collection('voting')
        .doc(vote.id)
        .collection("voters")
        .get();

    for (var voter in votersQuerySnapshot.docs) {
      Map<String, dynamic> voterMap = voter.data() as Map<String, dynamic>;
      if (voterMap["email"] == email) {
        votings.add(Voting.fromJson(vote.data() as Map<String, dynamic>));
      }
    }
  }
  return votings;
}

Future<QuerySnapshot> getAllCandidates(String voteId) {
  return FirebaseFirestore.instance
      .collection('voting')
      .doc(voteId)
      .collection('candidates')
      .get();
}

// total voters ++  (voting ) , voters counter ++ (candidate)
Future<bool> vote(Voting voting, Candidate candidate, BuildContext context) async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
      .instance
      .collection('voting')
      .doc(voting.voteId)
      .collection('voters')
      .get();
  for (var element in querySnapshot.docs) {
    Map<String, dynamic> data = element.data();
    if (data['email'] == AuthHelper.currentUser?.email && data["is_voted"]) {
       //not voted alert dialog
      showMessage("you cant vote twice in same election", context);

      return false;
    } else if(data['email'] == AuthHelper.currentUser?.email){
      FirebaseFirestore.instance
          .collection('voting')
          .doc(voting.voteId)
          .collection('voters')
          .doc(element.id)
          .update({
        'is_voted': true,
      });
    }
  }
  print("voted id -> ${voting.voteId}, total voters -> ${voting.totalVoters}");
  FirebaseFirestore.instance
      .collection('voting')
      .doc(voting.voteId)
      .update({'total_voters': ++voting.totalVoters});
  FirebaseFirestore.instance
      .collection('voting')
      .doc(voting.voteId)
      .collection('candidates')
      .doc(candidate.candidateId)
      .update({'voters_counter': ++candidate.votersCounter});
  return true;
}