import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'EmployeViewWithModel.dart';
import 'models/AllEmploye.dart';


class AllEmployeWithModel extends StatefulWidget
{
  @override
  State<AllEmployeWithModel> createState() => _AllEmployeWithModelState();
}

class _AllEmployeWithModelState extends State<AllEmployeWithModel>
{
  List<AllEmploye>? alldata;
  getdata() async
  {
    Uri url = Uri.parse("https://studiogo.tech/student/studentapi/getEmployee.php");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState(() {
        alldata = json["data"].map<AllEmploye>((obj)=>AllEmploye.fromJson(obj)).toList();
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
        title: Text("All Employe With Model"),
        centerTitle: true,
      ),
      body: (alldata==null)?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: alldata!.length,
        itemBuilder: (context, index)
        {
          return InkWell(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EmployeViewWithModel(
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
                    Text(alldata![index].eid.toString()),
                    Text(alldata![index].ename.toString()),
                    Text(alldata![index].salary.toString()),
                    Text(alldata![index].department.toString()),
                    Text(alldata![index].gender.toString()),
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
