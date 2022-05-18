import 'package:flutter_voting_app/data/my_user.dart';

Future<void>addUserToFireStore(MyUser user){
  return MyUser.withConverter().doc(user.id).set(user);

}