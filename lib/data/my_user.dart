import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser{
  static String collectionName = 'users';
  String id ;
  String userName ;
  String email ;
  bool firstLoginTime;

  MyUser({
    required this.id,
    required this.userName,
    required this.email,
    required this.firstLoginTime,
});

  MyUser.fromJson(Map<String,dynamic> json):this(
    id: json['id'] as String ,
    userName: json['userName'] as String,
    email: json['email'] as String,
    firstLoginTime: json['firstLoginTime'] as bool
  );
  Map<String , dynamic>toJson(){
    return {
      'id' : id ,
      'userName' : userName,
      'email' : email ,
      'firstLoginTime' : firstLoginTime
    };
  }
  static CollectionReference<MyUser>withConverter(){
    return FirebaseFirestore.instance.collection(collectionName).withConverter(
        fromFirestore: (snapshot,_)=> MyUser.fromJson(snapshot.data()!),
        toFirestore: (myUser,_)=> myUser.toJson()
    );

  }
}
