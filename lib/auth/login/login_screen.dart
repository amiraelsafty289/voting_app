import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voting_app/admin/admin_screen.dart';
import 'package:flutter_voting_app/data/auth_helper.dart';
import 'package:flutter_voting_app/data/my_user.dart';
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
  late MyUser myUser ;

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
                      controller: emailController,
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
                          prefixIcon: Icon(Icons.email),
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
                      controller: passwordController,
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'Please enter password';
                        }
                        if(text.length < 6){
                          return 'Password should be at least 6 chars ';
                        }
                        return null ;
                      },
                      obscureText: true ,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.password),
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
                          loginWithFirebaseAuthAsAdmin();
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
                            loginWithFirebaseAuthAsUser();
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

  void loginWithFirebaseAuthAsUser() async{
    try{
      showLoading(context);
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(result.user!.uid).get();
      Map<String,dynamic> json = snapshot.data() as Map<String , dynamic> ;
      myUser = MyUser.fromJson(json);
      hideLoading(context);
      if(result.user != null){
        showMessage('User Logged in Successfully', context);
        AuthHelper.currentUser = myUser ;
            Navigator.of(context).pushReplacementNamed(UserScreen.ROUTE_NAME,
          arguments: myUser
        );
            emailController.clear();
            passwordController.clear();
      }
    }catch(error){
      hideLoading(context);
      showMessage('Invalid Email Or Password', context);
    }
  }

  void loginWithFirebaseAuthAsAdmin()async {
    try{
      showLoading(context);
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      hideLoading(context);
      if(result.user != null && result.user!.email == 'admin@gmail.com'){
        showMessage('Admin Logged in Successfully', context);
        Navigator.of(context).pushReplacementNamed(AdminScreen.ROUTE_NAME);
        emailController.clear();
        passwordController.clear();
      }
    }catch(error){
      hideLoading(context);
      showMessage('Invalid Email Or Password', context);
    }
  }
}
