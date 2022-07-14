import 'package:flutter/material.dart';
import 'package:flutter_voting_app/data/firebase_utils.dart';
import 'package:flutter_voting_app/my_theme.dart';

class VotersScreen extends StatelessWidget {
  static String ROUTE_NAME = 'voters';
  var formKey = GlobalKey<FormState>();

  String voteId = '';

  String voterEmail = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.background,
      appBar: AppBar(
        backgroundColor: MyThemeData.dark_blue,
        centerTitle: true,
        title: Text(
          'Create Voters',
          style: TextStyle(
              color: MyThemeData.white,
              fontSize: 35,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.5,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
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
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    TextFormField(
                      onChanged: (text) {
                        voterEmail = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Voter Email ',
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
            addVoter(voteId, voterEmail, context);
            Navigator.pop(context);
          }
        },
        backgroundColor: MyThemeData.dark_blue,
      ),
    );
  }
}
