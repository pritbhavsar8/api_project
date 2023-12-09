import 'package:api_project/AllProduct.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddEmploye.dart';
import 'AllEmployeWithModel.dart';
import 'AllEmployes.dart';
import 'AllProductWithModel.dart';
import 'FakeProduct1.dart';
import 'FakeProduct2.dart';
import 'LoginScreen.dart';
import 'SocialCommunity.dart';
import 'ViewScreen.dart';
import 'AddProduct.dart';

class HomeScreen extends StatefulWidget
{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  var id = "";
  var name = "";
  var email = "";
  var user_session_token= "";
  getdata() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
     id = prefs.getString("id").toString();
     name = prefs.getString("name").toString();
     email =  prefs.getString("email").toString();
     user_session_token = prefs.getString("user_session_token").toString();
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async{
            SharedPreferences prefs =  await SharedPreferences.getInstance();
            prefs.clear();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginScreen(),)
            );
          }, icon: Icon(Icons.logout))
        ],
        centerTitle: true,
        title: Text("HomeScreen"),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.0,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop;
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FakeProduct1(),)
                    );
                  },
                  child: Text("Fake Product 1")
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop;
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FakeProduct2(),)
                    );
                  },
                  child: Text("Fake Product 2")
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop;
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AllEmployes(),)
                    );
                  },
                  child: Text("All Employes"),
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop;
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AllProduct(),)
                    );
                  },
                  child: Text("All Product"),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop;
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddProduct(),)
                  );
                },
                child: Text("Add Product"),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop;
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddEmploye(),)
                  );
                },
                child: Text("Add Employe"),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop;
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AllProductWithModel(),)
                  );
                },
                child: Text("AllProduct With Model"),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop;
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AllEmployeWithModel(),)
                  );
                },
                child: Text("AllEmploye With Model"),
              ),

              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop;
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>SocialCommunity(),)
                  );
                },
                child: Text("social-community"),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.green.shade50
          ),
          child: Column(
            children: [
              Text(id),
              Text(name),
              Text(email),
              Text(user_session_token),
            ],
          ),
        ),
      ),
    );
  }
}
