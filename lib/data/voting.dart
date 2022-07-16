import 'package:cloud_firestore/cloud_firestore.dart';

class Voting{
  String? voteId ;
  String voteName ;
  int startDate ;
  int endDate ;
  int totalVoters ;

  Voting({this.voteId, required this.voteName, required this.startDate,
    required this.endDate , required this.totalVoters});

  Voting.fromJson(Map<String,dynamic> json):this(
       voteId: json['vote_id'] as String ,
      voteName: json['vote_name'] as String,
      startDate: json['start_date'] as int,
      endDate: json['end_date'] as int,
    totalVoters: json["total_voters"]
  );
  Map<String , dynamic>toJson(){
    return {
      'vote_id' : voteId ,
      'vote_name' : voteName,
      'start_date' : startDate ,
      'end_date' : endDate,
      'total_voters' :totalVoters
    };
  }
  static CollectionReference<Voting>withConverter(){
    return FirebaseFirestore.instance.collection('elections').withConverter(
        fromFirestore: (snapshot,_)=> Voting.fromJson(snapshot.data()!),
        toFirestore: (election,_)=> election.toJson()
    );

  }

}