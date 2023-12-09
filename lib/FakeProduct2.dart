import 'dart:convert';

import 'package:api_project/models/Product2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'FakeProduct2View.dart';

class FakeProduct2 extends StatefulWidget
{
  @override
  State<FakeProduct2> createState() => _FakeProduct2State();
}

class _FakeProduct2State extends State<FakeProduct2>
{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  List<Product2>? alldata;
  getdata() async
  {
    //200 OK
    //400 API not found
    //500 Server prob
    Uri url = Uri.parse("https://api.escuelajs.co/api/v1/products");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      //1. Json Loop
      //2. Single obj
      //3. json object class obj
      //4. all object store to list

      setState(() {
        alldata = json.map<Product2>((obj)=>Product2.fromJson(obj)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FakeProduct2"),
        centerTitle: true,
      ),
      body: (alldata==null)?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: alldata!.length,
        itemBuilder: (context, index)
        {
          return ListTile(
            title:   Text(alldata![index].title.toString()),
            leading: Image.network(alldata![index].images![1].toString()),
            trailing: Text("Rs" + alldata![index].price.toString()),
            subtitle:  Text(alldata![index].description.toString()),
            onTap: (){
             Navigator.of(context).push(
               MaterialPageRoute(builder: (context) => FakeProduct2View(
                 obj: alldata![index],
               ),)
             );
            },
          );

        },
      ) ,
    );
  }
}
