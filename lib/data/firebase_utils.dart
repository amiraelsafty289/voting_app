import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voting_app/data/auth_helper.dart';
import 'package:flutter_voting_app/data/candidate.dart';
import 'package:flutter_voting_app/data/voting.dart';
import 'package:flutter_voting_app/data/my_user.dart';
import 'package:flutter_voting_app/utils.dart';

Future<void>addUserToFireStore(MyUser user){
  return MyUser.withConverter().doc(user.id).set(user);
}

Future<bool> createVoting(String voteId , String voteName , DateTime startDate , DateTime endDate , BuildContext context)async {
  // law id mawgood hyd5l wa7d tany
  bool isExist = await checkId(voteId);
  if(isExist){
    showMessage('Please enter another vote Id', context);
    return false ;
  }
 DocumentReference docRef =  FirebaseFirestore.instance.collection('voting').doc(voteId);
 docRef.set(
   {
     'vote_id' : voteId ,
     'vote_name' : voteName ,
     'start_date' : startDate.millisecondsSinceEpoch,
     'end_date' : endDate.millisecondsSinceEpoch,
     'total_voters' : 0
   }
 );
 return true ;
}

Future<bool> checkId (String id) async{
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('voting').get();
  print('SnapShot : ${snapshot.docs}');
  bool isExist = false ;
  for (var element in snapshot.docs) {
    print('ElementId : ${element.id}');
    if(element.id == id){
      isExist = true ;
    }
  }
  return isExist ;
}

addVoter(String voteId , String email , BuildContext context)async {
  // law id msh mawgood d5l wa7d tany gded
  bool isExist = await checkId(voteId) ;
  if(isExist){
    showMessage('Please enter another voter id', context);
    return ;
  }
  FirebaseFirestore.instance.collection('voting').doc(voteId).collection('voters').doc().set({
    'email' : email,
    'is_voted' : false ,
    // 'is_voted' : false
  }).then((value) {
    showMessage('Voters added Successfully', context);
  }).onError((error, stackTrace){
    print(error.toString());
    showMessage('Try again to added new voter', context);
  });
}

addCandidate(String voteId , String name , String age , String description , BuildContext context , String candidateId )async{
  // law id fady yrou7 yd5l wa7d tany
  bool isExist = await checkId(voteId) ;
  if(isExist){
    showMessage('Please enter another vote id', context);
    return ;
  }
  DocumentReference doc =FirebaseFirestore.instance.collection('voting').doc(voteId).collection('candidates').doc();
     doc.set({
    'name' : name ,
    'age' : age ,
    'description' : description,
       'candidate_id':doc.id,
       'image' : '',
       'voters_counter' : 0
  }).then((value){
    showMessage('Candidates added Successfully', context);
  }).onError((error, stackTrace){
    print(error.toString());
    showMessage('Try again to add another candidates', context);
  });
}

Future<QuerySnapshot> getAllVotings(){
  return FirebaseFirestore.instance.collection('voting').get();
}

Future<QuerySnapshot> getAllCandidates(String voteId){
 return FirebaseFirestore.instance.collection('voting').doc(voteId).collection('candidates').get();
}
// total voters ++  (voting ) , voters counter ++ (candidate)
void vote(Voting voting , Candidate candidate , BuildContext context) async{

  QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('voting').doc(voting.voteId).collection('voters').get();
  for(var element in querySnapshot.docs){
    Map<String,dynamic> data = element.data();
    if(data['email'] == AuthHelper.currentUser?.email){
      // not voted alert dialog
      showMessage('You can not voted', context);
      return ;
    }else{
      FirebaseFirestore.instance.collection('voting').doc(voting.voteId).collection('voters').doc(element.id).update({
        'is_voted' : true ,
      });
    }
  }
  FirebaseFirestore.instance.collection('voting').doc(voting.voteId).update({
    'total_voters': ++voting.totalVoters
  });
  FirebaseFirestore.instance.collection('voting').doc(voting.voteId).collection('candidates').doc(candidate.candidateId).update({
    'voters_counter' : ++ candidate.votersCounter
  });
}







// QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('voting').doc(voting.voteId).collection('voters').get();
// for (var element in querySnapshot.docs) {
// Map<String,dynamic> data = element.data();
// if(data['email']== AuthHelper.currentUser?.email){
// if( data['is_voted'] == true){
// // alert dialog mynf34 y voted tany 34an voted 2bl kda
// return ;
// }else{
// FirebaseFirestore.instance.collection('voting').doc(voting.voteId).collection('voters').doc(element.id).update({
// 'is_voted' : true
// });
// }
// }
// }