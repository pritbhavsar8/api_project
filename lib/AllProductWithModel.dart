import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_project/models/AllProduct.dart';
import 'package:flutter/material.dart';
import 'AllProductView.dart';

class AllProductWithModel extends StatefulWidget
{

  @override
  State<AllProductWithModel> createState() => _AllProductWithModelState();
}

class _AllProductWithModelState extends State<AllProductWithModel>
{
  List<AllProduct>? alldata;
  getdata() async
  {
    Uri url = Uri.parse("https://studiogo.tech/student/studentapi/getProducts.php");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState(() {
        alldata = json["data"].map<AllProduct>((obj)=>AllProduct.fromJson(obj)).toList();
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
        title: Text("All Product With Model"),
        centerTitle: true,
      ),
      body: (alldata==null)?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: alldata!.length,
        itemBuilder: (context, index)
        {
          return InkWell(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AllProductView(
                  obj: alldata![index],
                ),),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10.0),
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    Text(alldata![index].pid.toString()),
                    Text(alldata![index].pname.toString()),
                    Text(alldata![index].qty.toString()),
                    Text(alldata![index].price.toString()),
                    Text(alldata![index].addedDatetime.toString()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
