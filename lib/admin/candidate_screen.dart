import 'package:flutter/material.dart';
import 'package:flutter_voting_app/data/firebase_utils.dart';
import 'package:flutter_voting_app/my_theme.dart';

import '../utils.dart';

class CandidateScreen extends StatefulWidget {
  static String ROUTE_NAME = 'candidate';

  @override
  State<CandidateScreen> createState() => _CandidateScreenState();
}

class _CandidateScreenState extends State<CandidateScreen> {
  var formKey = GlobalKey<FormState>();

  String image = '';

  String name = '';

  String age = '';

  String voteId = '';

  String description = '';

  String candidateId = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyThemeData.background,
      appBar: AppBar(
        backgroundColor: MyThemeData.dark_blue,
        centerTitle: true,
        title: Text(
          'Create Candidates',
          style: TextStyle(
              color: MyThemeData.white,
              fontSize: 35,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.7,
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.10),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyThemeData.dark_blue, width: 3)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      child: Image.asset(
                        'assets/images/login_image.png',
                        width: 90,
                        height: 90,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    TextFormField(
                      onChanged: (text) {
                        voteId = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Vote Id',
                          labelStyle: TextStyle(
                              color: MyThemeData.gray,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: MyThemeData.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: MyThemeData.dark_blue, width: 3))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    TextFormField(
                      onChanged: (text) {
                        name = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                              color: MyThemeData.gray,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: MyThemeData.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: MyThemeData.dark_blue, width: 3))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    TextFormField(
                      onChanged: (text) {
                        age = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Age ',
                          labelStyle: TextStyle(
                              color: MyThemeData.gray,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: MyThemeData.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: MyThemeData.dark_blue, width: 3))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    TextFormField(
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintMaxLines: 5,
                          labelText: 'Description ',
                          labelStyle: TextStyle(
                              color: MyThemeData.gray,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: MyThemeData.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: MyThemeData.dark_blue, width: 3))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: MyThemeData.white, size: 30),
        onPressed: () {
          if (formKey.currentState?.validate() == true) {
            addCandidate(voteId, name, age, description, context, candidateId).then((value) {
              showMessage('Candidates added Successfully', context);
            }).onError((error, stackTrace) {
              print("Error -> ${error.toString()} \n stacktrace -> ${stackTrace}");
              showMessage('Try again to add another candidates', context);
            });
            Navigator.pop(context);
          }
        },
        backgroundColor: MyThemeData.dark_blue,
      ),
    );
  }
}
