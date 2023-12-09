import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ViewScreen extends StatefulWidget
{
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen>
{

  Future<List>? alldata;
  Future<List> getdata() async

  {
    //200 OK
    //400 API not found
    //500 Server prob
   // Uri url = Uri.parse("https://api.escuelajs.co/api/v1/products");
   // Uri url = Uri.parse("https://fakestoreapi.com/products");
    Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/getEmployee.php");
   // Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/getProducts.php");
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);
        var pname = json["data"][1]["pname"].toString();
        var status = json["status"];
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
        centerTitle: true,
        title: Text("View Screen"),
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
                        child: Column(
                          children: [
                            Text(snapshots.data![index]["pid"].toString()),
                            Text(snapshots.data![index]["pname"].toString()),
                            Text(snapshots.data![index]["qty"].toString()),
                            Text(snapshots.data![index]["price"].toString()),
                            Text(snapshots.data![index]["added_datetime"].toString()),

                          ],
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
