import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditEmployes extends StatefulWidget
{

  var eid = "";
  EditEmployes({required this.eid});

  @override
  State<EditEmployes> createState() => _EditEmployesState();
}

class _EditEmployesState extends State<EditEmployes>
{
  TextEditingController _name = TextEditingController();
  TextEditingController _salary = TextEditingController();
  var selected = "sale";
  var gender = "male";
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EditEmployes"),
        backgroundColor: Colors.grey.shade900,
        toolbarHeight: 70,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 600,
            margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.all(15.0),
            color: Color(0xfffff3e0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0,),
                Text("Name"),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0),
                        borderSide: BorderSide(
                            color: Colors.grey
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Text("Salary"),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _salary,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0),
                        borderSide: BorderSide(
                            color: Colors.grey
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Text("gender"),
                SizedBox(height: 15.0,),
                Row(
                  children: [
                    Radio(
                        value: "male",
                        groupValue: gender,
                        onChanged: (val){
                          setState(() {
                            gender=val!;
                          });
                        }
                    ),
                    Text("Male"),
                    SizedBox(width: 15.0,),
                    Radio(
                        value: "female",
                        groupValue: gender,
                        onChanged: (val){
                          setState(() {
                            gender=val!;
                          });
                        }
                    ),
                    Text("Female"),
                  ],
                ),
                SizedBox(height: 10.0,),
                Text("Department"),
                DropdownButton(
                  dropdownColor: Colors.orangeAccent.shade100,
                  value: selected,
                  onChanged: (val){
                    setState(() {
                      selected=val!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text("Sale"),
                      value: "sale",
                    ),
                    DropdownMenuItem(
                      child: Text("HR"),
                      value: "hr",
                    ),
                    DropdownMenuItem(
                      child: Text("Purchase"),
                      value: "purchase",
                    ),
                  ],
                ),
                SizedBox(height: 10.0,),
                //Button

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300.0,
                      child: ElevatedButton(
                        onPressed: () async{
                          var name = _name.text.toString();
                          var salary = _salary.text.toString();
                          var Gender = gender;
                          var department = selected;

                          Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/insertEmployeeNormal.php");

                          var para = {
                            "ename":name,
                            "salary": salary,
                            "department":department,
                            "gender": Gender,
                          };
                          var response = await http.post(url,body: para);
                          // if(response.statusCode==200)
                          //   {
                          //     var body = response.body.toString();
                          //     var json = jsonDecode(body);
                          //   }
                          if(response.statusCode==200)
                          {
                            var json = jsonDecode(response.body.toString());
                            setState(() {
                              isloading=false;
                            });
                            if(json["status"]=="true")
                            {
                              var message = json["message"].toString();
                              _name.text = "";
                              _salary.text = "";
                              setState(() {
                                selected = "sale";
                                gender = "male";
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message,style: TextStyle(color: Colors.white),),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                            else
                            {
                              var message = json["message"].toString();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message,style: TextStyle(color: Colors.white),),
                                    backgroundColor: Colors.red,
                                  )
                              );
                            }
                          }


                        },
                        child: Text("Update"),
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
