import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voting_app/data/firebase_utils.dart';
import 'package:flutter_voting_app/data/my_user.dart';
import 'package:flutter_voting_app/my_theme.dart';
import 'package:flutter_voting_app/utils.dart';

import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static String ROUTE_NAME = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = '' ;

  String password = '' ;

  String userName = '';

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.background,
      appBar: AppBar(
        backgroundColor: MyThemeData.dark_blue,
        centerTitle: true,
        title: Text('Register Screen',
          style: TextStyle(
              color: MyThemeData.white,
              fontSize: 35,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
         margin: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Create new user account :',
                style: TextStyle(
                  fontSize:30,
                  fontWeight: FontWeight.bold,
                  color: MyThemeData.dark_blue,
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.09,),
                    TextFormField(
                      onChanged: (text){
                        userName = text ;
                      },
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'Please enter name';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                          labelText: 'User Name',
                          labelStyle: TextStyle(
                              color: MyThemeData.gray,
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),
                          filled: true,
                          fillColor: MyThemeData.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: MyThemeData.dark_blue , width: 3)
                          )
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                    TextFormField(
                      onChanged: (text){
                        email = text ;
                      },
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'Please enter email address';
                        }
                        if(!isValidEmail(email)){
                          return 'Please enter a valid email ';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                          labelText: 'Email ',
                          labelStyle: TextStyle(
                              color: MyThemeData.gray,
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),
                          filled: true,
                          fillColor: MyThemeData.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: MyThemeData.dark_blue , width: 3)
                          )
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                    TextFormField(
                      onChanged: (text){
                        password = text ;
                      },
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'Please enter password';
                        }
                        if(text.length < 6){
                          return 'Password should be at least 6 chars ';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: MyThemeData.gray,
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),
                          filled: true,
                          fillColor: MyThemeData.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: MyThemeData.dark_blue , width: 3)
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: MyThemeData.white, size: 30),
        onPressed: (){
          if(formKey.currentState?.validate() == true){
            createAccountWithFirebaseAuth();
          }
        },
        backgroundColor: MyThemeData.dark_blue,
      ),
    );
  }

  void createAccountWithFirebaseAuth()async {
    try{
      showLoading(context);
      UserCredential result =  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      hideLoading(context);
      if(result.user != null){
        showMessage('User Registered Successfully', context);
        var myUser = MyUser(
            id:result.user!.uid ,
            userName: userName,
            email: email,
            firstLoginTime: true);
        addUserToFireStore(myUser).then((value){
          Navigator.of(context).pushNamed(LoginScreen.ROUTE_NAME);
        }).onError((error, stackTrace) {
          showMessage(error.toString(), context);
        });
      }
    }
    catch(error){
      hideLoading(context);
      showMessage(error.toString(), context);
    }

  }
}
