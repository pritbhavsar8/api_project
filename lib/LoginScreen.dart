import 'dart:convert';
import 'package:api_project/HomeScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget
{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Color(0xffFBFAFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.0,),
            Text("Login",style: TextStyle(
              fontFamily: "SourceSansPro",
              fontWeight: FontWeight.w700,
              color: Color(0xff010101),
              fontSize: 20.0,
            ),),
            SizedBox(height: 20.0,),
            //Text Field,
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(15.0),
              child: TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    label : Text("Email",style: TextStyle(
                        color:Colors.grey
                    ),),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    )
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(15.0),
              child: TextField(
                obscureText: true,
                controller: _password,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.remove_red_eye_sharp),
                    label : Text("Password",style: TextStyle(
                        color:Colors.grey
                    ),),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    )
                ),
              ),
            ),
            //button
            Container(
              width: 130.0,
              child: ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    backgroundColor: Color(0xffFE7551),
                    foregroundColor: Colors.white,
                  ) ,
                  onPressed: () async{
                    var name = _email.text.toString();
                    var password = _password.text.toString();

                    Uri url = Uri.parse("https://begratefulapp.ca/api/login");
                    var params = {
                      "name": name,
                      "password": password,
                      "device_token":"12345678",
                      "device_os":"android"
                    };

                    var h = {
                      "Content-Type":"application/json"
                    };

                    var response = await http.post(url,body: jsonEncode(params),headers: h);
                    if(response.statusCode==200)
                      {
                        var json = jsonDecode(response.body.toString());
                        if(json["result"]=="success")
                          {
                            var id = json["data"]["id"].toString();
                            var name = json["data"]["name"].toString();
                            var email = json["data"]["email"].toString();
                            var user_session_token = json["data"]["user_session_token"].toString();

                            //SP
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("id", id);
                            prefs.setString("name", name);
                            prefs.setString("email", email);
                            prefs.setString("user_session_token", user_session_token);
                            prefs.setBool("islogin", true);
                            Navigator.of(context).push(
                             MaterialPageRoute(builder: (context) => HomeScreen(),)
                            );
                            
                            var message = json["message"].toString();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message,style: TextStyle(color: Colors.white),),
                                backgroundColor: Colors.green,
                              )
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
                  child: Text("Login")
              ),
            ),
            SizedBox(height: 10.0,),
            RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Don’t Have an account?",
                          style: TextStyle(
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w600,
                            color: Color(0xff010101),
                            fontSize: 15.0,
                          )
                      ),
                      TextSpan(
                          text: " Create",
                          recognizer: TapGestureRecognizer()..onTap = (){
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => LoginScreen(),)
                            );
                          },
                          style: TextStyle(
                            fontFamily: "SourceSansPro",
                            fontWeight: FontWeight.w600,
                            color: Color(0xffFE7551),
                            fontSize: 15.0,
                          )
                      ),
                    ]
                )
            )
          ],
        ),
      ),

    );
  }
}

