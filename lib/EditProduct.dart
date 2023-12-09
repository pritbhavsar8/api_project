import 'dart:convert';
import 'package:api_project/AllProduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class EditProduct extends StatefulWidget
{
  var pid="";
  EditProduct({required this.pid});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct>
{
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _qty = TextEditingController();

  bool isloading=false;

  getdata() async
  {
    setState(() {
      isloading=true;
    });
    Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/getSingleProduct.php");
    var params = {
      "pid":widget.pid
    };
    var response = await http.post(url,body: params);
    if(response.statusCode==200)
      {
        var json = jsonDecode(response.body.toString());
        _name.text = json["data"]["pname"].toString();
        _qty.text = json["data"]["qty"].toString();
        _price.text = json["data"]["price"].toString();
        setState(() {
          isloading=false;
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
        backgroundColor: Colors.grey.shade200,
        toolbarHeight: 70.0,
        title: Text("EditProduct"),
        centerTitle: true,
      ),
      body:  (isloading)?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.all(15.0),
            color: Color(0xfffff3e0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0,),
                Text("Name:"),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0),
                          borderSide: BorderSide(
                              color: Colors.grey
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Text("Qty:"),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _qty,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0),
                          borderSide: BorderSide(
                              color: Colors.grey
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Text("Price:"),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _price,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0),
                          borderSide: BorderSide(
                              color: Colors.grey
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),

                //Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300.0,
                      child: ElevatedButton(
                        onPressed: () async{
                          var name  = _name.text.toString();
                          var qty  = _qty.text.toString();
                          var price  = _price.text.toString();


                          setState(() {
                            isloading=true;
                          });
                          
                          Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/updateProductNormal.php");

                          var params = {
                            "pname":name,
                            "qty":qty,
                            "price":price,
                            "pid":widget.pid
                          };
                          var response = await http.post(url,body: params);
                          if(response.statusCode==200)
                          {
                            var json = jsonDecode(response.body.toString());
                            setState(() {
                              isloading=false;
                            });
                            if(json["status"]=="true")
                            {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>AllProduct())
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
                        child: Text("Update"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )
                        ),

                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),


    );
  }
}
