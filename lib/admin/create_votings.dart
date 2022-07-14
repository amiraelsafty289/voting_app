import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_voting_app/data/firebase_utils.dart';
import 'package:flutter_voting_app/my_theme.dart';

import '../utils.dart';

class VotingScreen extends StatefulWidget {
  static String ROUTE_NAME = 'voting';

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  var formKey = GlobalKey<FormState>();

  String voteId = '';

  String voteName = '';

  DateTime selectedDateOfStartDate = DateTime.now();

  DateTime selectedDateOfEndDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.background,
      appBar: AppBar(
        backgroundColor: MyThemeData.dark_blue,
        centerTitle: true,
        title: Text('Create Voting',
          style: TextStyle(
              color: MyThemeData.white,
              fontSize: 35,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width*0.8,
        height: MediaQuery.of(context).size.height*0.62,
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height*0.05,
            vertical: MediaQuery.of(context).size.height*0.10),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.05),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color:MyThemeData.dark_blue,width: 3 )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    TextFormField(
                      onChanged: (text){
                        voteId = text ;
                      },
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'Please enter Vote Id';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                          labelText: 'Vote Id',
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
                    SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                    TextFormField(
                      onChanged: (text){
                        voteName = text ;
                      },
                      validator: (text){
                        if(text == null || text.trim().isEmpty){
                          return 'Please enter Vote Name';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                          labelText: 'Vote Name ',
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
                    SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                    Text('Start Date',
                      style: TextStyle(
                          color: MyThemeData.dark_blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: MyThemeData.dark_blue,width: 2)
                      ),
                        child: InkWell(
                          onTap: (){
                            showCalendarOfStartDate();
                          },
                          child: Text('${selectedDateOfStartDate.day}/${selectedDateOfStartDate.month}/${selectedDateOfStartDate.year}',
                            style: TextStyle(
                              color: MyThemeData.dark_blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                    Text('End Date',
                      style: TextStyle(
                          color: MyThemeData.dark_blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: MyThemeData.dark_blue,width: 2)
                        ),
                        child:  InkWell(
                          onTap: (){
                            showCalendarOfEndDate();
                          },
                          child: Text('${selectedDateOfEndDate.day}/${selectedDateOfEndDate.month}/${selectedDateOfEndDate.year}',
                            style: TextStyle(
                                color: MyThemeData.dark_blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
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
            createVoting(voteId, voteName, selectedDateOfStartDate, selectedDateOfEndDate, context).then((value){
              if(!value){
                showMessage('Please enter another vote Id', context);
              }
            });
            Navigator.pop(context);
          }
        },
        backgroundColor: MyThemeData.dark_blue,
      ),

    );
  }

  void showCalendarOfStartDate() async{
   var newSelectedDate = await  showDatePicker(
       context: context,
       initialDate: selectedDateOfStartDate,
       firstDate: DateTime.now(),
       lastDate: DateTime.now().add(Duration(days: 365))
   );
   if(newSelectedDate!= null){
       selectedDateOfStartDate= newSelectedDate;
       setState(() {

       });
   }

  }
  void showCalendarOfEndDate() async{
    var newSelectedDate = await  showDatePicker(
        context: context,
        initialDate: selectedDateOfEndDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
    if(newSelectedDate!= null){
      selectedDateOfEndDate= newSelectedDate;
      setState(() {

      });
    }

  }
}
