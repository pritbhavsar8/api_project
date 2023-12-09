import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AddProduct.dart';
import 'EditProduct.dart';

class AllProduct extends StatefulWidget
{
  @override
  State<AllProduct> createState() => _AllProduct();
}

class _AllProduct extends State<AllProduct>
{

  Future<List>? alldata;
  Future<List> getdata() async
  {
    //200 OK
    //400 API not found
    //500 Server prob
    Uri url = Uri.parse("https://studiogo.tech/student/studentapi/getProducts.php");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      // var pname = json["data"][1]["pname"].toString();
      // var status = json["status"];
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
        title: Text("AllProduct"),
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
                    margin: EdgeInsets.all(10.0),
                    child: Card(
                      shadowColor: Colors.red.shade900,
                      elevation: 5,
                      child: Column(
                        children: [
                          Text("pid ="+snapshots.data![index]["pid"].toString()),
                          Text("pname ="+snapshots.data![index]["pname"].toString()),
                          Text("qty ="+snapshots.data![index]["qty"].toString()),
                          Text("price ="+snapshots.data![index]["price"].toString()),
                          Text("added_datetime ="+snapshots.data![index]["added_datetime"].toString()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () async{
                                    var pid = snapshots.data![index]["pid"].toString();
                                    Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/deleteProductNormal.php");
                                    var params = {
                                      "pid":pid
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

                                    var pid = snapshots.data![index]["pid"].toString();

                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => EditProduct(
                                        pid: pid,
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