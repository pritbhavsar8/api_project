import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'FakeProduct1View.dart';

class FakeProduct1 extends StatefulWidget
{

  @override
  State<FakeProduct1> createState() => _FakeProduct1State();
}

class _FakeProduct1State extends State<FakeProduct1>
{
  Future<List>? alldata;
  Future<List> getdata() async

  {
    //200 OK
    //400 API not found
    //500 Server prob
     Uri url = Uri.parse("https://fakestoreapi.com/products");

    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      return json;
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
    return Scaffold (
      appBar: AppBar(
        title: Text("FakeProduct1"),
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
                  return ListTile(
                    title:   Text(snapshots.data![index]["title"].toString()),
                    leading: Image.network(snapshots.data![index]["image"].toString()),
                    trailing: Text(snapshots.data![index]["rating"]["rate"].toString()),
                    subtitle:  Text("Rs" + snapshots.data![index]["price"].toString()),
                    onTap: (){
                      var title = (snapshots.data![index]["title"].toString());
                      var subtitle = ("Rs" + snapshots.data![index]["price"].toString());
                      var img = (snapshots.data![index]["image"].toString());
                      var rate = (snapshots.data![index]["rating"]["rate"].toString());
                      Navigator.of(context).pop;
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FakeProductView(
                          title:title,
                          subtitle: subtitle,
                          img: img,
                          rate: rate,
                        ),),
                      );
                    },
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
