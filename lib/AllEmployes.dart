import 'package:api_project/EditEmployes.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AllEmployes extends StatefulWidget {
  @override
  State<AllEmployes> createState() => _AllEmployesState();
}

class _AllEmployesState extends State<AllEmployes>
{
  Future<List>? alldata;
  Future<List> getdata() async

  {
    //200 OK
    //400 API not found
    //500 Server prob

    Uri url = Uri.parse("https://studiogo.tech/student/studentapi/getEmployee.php");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      //var status = json["status"];
      return json["data"];
    }
    else
    {
      return [];
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AllEmployes"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context,snapshots)
        {
          if(snapshots.hasData)
          {
            if(snapshots.data!.length<=0)
            {
              return Center(
                child: Text("No data"),
              );
            }
            else
            {
              return ListView.builder(
                itemCount: snapshots.data!.length,
                itemBuilder: (context,index)
                {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(10),
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.red.shade900,
                      child: Column(
                        children: [
                          Text("eid: " + snapshots.data![index]["eid"].toString()),
                          Text("ename: " + snapshots.data![index]["ename"].toString()),
                          Text("salary: " + snapshots.data![index]["salary"].toString()),
                          Text("department: " + snapshots.data![index]["department"].toString()),
                          Text("gender: " + snapshots.data![index]["gender"].toString()),
                          Text("added_datetime: " + snapshots.data![index]["added_datetime"].toString()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () async{
                                    var eid = snapshots.data![index]["eid"].toString();
                                    Uri url = Uri.parse("https://studiogo.tech/student/studentapi/getEmployee.php");
                                    var params = {
                                      "eid": eid,
                                    };
                                    var response = await http.post(url,body: params);
                                    if(response.statusCode==200)
                                    {
                                      var json = jsonDecode(response.body.toString());
                                      if(json["status"]=="true")
                                      {
                                        var message = json["message"].toString();

                                        setState(() {
                                          alldata = getdata();
                                        });
                                      }
                                      else
                                      {
                                        var message = json["message"].toString();
                                      }
                                    }
                                  },
                                  icon: Icon(Icons.delete_rounded,color: Colors.red,)
                              ),
                              IconButton(
                                  onPressed: (){
                                    var eid = snapshots.data![index]["eid"].toString();

                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => EditEmployes(
                                        eid: eid,
                                      ),)
                                    );
                                  },
                                  icon: Icon(Icons.edit,color: Colors.green,)
                              )
                            ],
                          )
                        ],

                      ),
                    ),

                   );
                },
              );
            }
          }
          else
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
