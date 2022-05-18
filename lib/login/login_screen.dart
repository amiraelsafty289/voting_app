import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voting_app/my_theme.dart';
import 'package:flutter_voting_app/user/user_screen.dart';
import 'package:flutter_voting_app/utils.dart';

class LoginScreen extends StatefulWidget{
  static String ROUTE_NAME = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';

  String password = '';

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyThemeData.dark_blue,
        centerTitle: true,
        title: Text('Vote Chain',
          style: TextStyle(
            color: MyThemeData.white,
            fontSize: 35,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/login_image.png',
                width: MediaQuery.of(context).size.width*0.35,
                height: MediaQuery.of(context).size.height*0.15,
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.08,),
              Form(
                key: formKey ,
                child: Column(
                  children: [
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
                        labelText: 'Email Address',
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
                    SizedBox(height: MediaQuery.of(context).size.height*0.08,),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                        backgroundColor: MaterialStateProperty.all(MyThemeData.dark_blue),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(color: MyThemeData.dark_blue)
                              )
                          )
                      ),
                        onPressed: (){
                        if(formKey.currentState?.validate() == true){
                          // login as admin
                        }
                        },
                        child: Text('LOGIN AS ADMIN',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: MyThemeData.white
                          ),
                        )
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                    ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                            backgroundColor: MaterialStateProperty.all(MyThemeData.dark_blue),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(color: MyThemeData.dark_blue)
                                )
                            )
                        ),
                        onPressed: (){
                          if(formKey.currentState?.validate() == true){
                            loginWithFirebaseAuth();
                          }
                        },
                        child: Text('LOGIN AS USER ',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: MyThemeData.white
                          ),
                        )
                    ),

                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  void loginWithFirebaseAuth() async{
    try{
      showLoading(context);
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      hideLoading(context);
      if(result.user != null){
        showMessage('User Logged in Successfully', context);
        Navigator.of(context).pushNamed(UserScreen.ROUTE_NAME);
      }
    }catch(error){
      hideLoading(context);
      showMessage('Invalid Email Or Password', context);
    }
  }
}
