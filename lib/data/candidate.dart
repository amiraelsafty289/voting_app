import 'package:cloud_firestore/cloud_firestore.dart';

class Candidate{
  String candidateId ;
  String name ;
  String age  ;
  String image ;
  String description ;
  int votersCounter ;


  Candidate({required this.candidateId, required this.name,
    required this.age, required this.image , required this.description ,
    required this.votersCounter});

  Candidate.fromJson(Map<String,dynamic> json):this(
      candidateId: json['candidate_id'] as String,
      name: json['name'] as String,
      age: json['age'] as String,
    image: '',
    description: json['description'] as String,
    votersCounter:  0
  );
  Map<String , dynamic>toJson(){
    return {
      'candidate_id' : candidateId ,
      'name' : name,
      'age' : age ,
      'image' : '',
      'description' : description,
      'voters_counter' : 0
    };
  }
  static CollectionReference<Candidate>withConverter(){
    return FirebaseFirestore.instance.collection('candidates').withConverter(
        fromFirestore: (snapshot,_)=> Candidate.fromJson(snapshot.data()!),
        toFirestore: (candidate,_)=> candidate.toJson()
    );

  }

}