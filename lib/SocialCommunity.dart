import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/Community.dart';

class SocialCommunity extends StatefulWidget
{
  @override
  State<SocialCommunity> createState() => _SocialCommunityState();
}

class _SocialCommunityState extends State<SocialCommunity> {


  List<Community>? alldata;
  

  getdata() async
  {
    Uri url = Uri.parse("https://begratefulapp.ca/api/social-community");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var params ={
      "user_id": prefs.getString("id").toString(),
      "page": "1"
    };
    var h = {
      "user_session_token":prefs.getString("user_session_token").toString(),
      "Content-Type":"application/json"
    };

    var response = await http.post(url,body: jsonEncode(params),headers: h);
    if(response.statusCode == 200)
      {
        var json = jsonDecode(response.body.toString());
        print(json);
        setState(() {
          alldata = json["data"].map<Community>((obj)=>Community.fromJson(obj)).toList();
        });
      }
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
        title: Text("SocialCommunity"),
        centerTitle: true,
      ),
      body: (alldata==null)?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: alldata!.length,
          itemBuilder: (context, index)
          {
            DateTime dateTime = DateTime.parse(alldata![index].date.toString());
            String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);



            var hexColor = alldata![index].color.toString();
            hexColor = hexColor.substring(1);

             return Container(
              width: MediaQuery.of(context).size.width,

              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Card(
                elevation: 5,
                color:  Color(int.parse('0xff$hexColor')),
                child:  Row(
                  children: [
                    Image.network(alldata![index].categoryImage.toString(),width: 100,height: 100,),
                    Expanded(child: Column(
                      children: [
                      Text(alldata![index].gratitude.toString()),
                      Text(formattedDate.toString())
                      ],
                    ))
                  ],
                ),
              ),
            );
          },
      ),
    );
  }
}
