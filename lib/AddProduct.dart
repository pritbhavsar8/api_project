import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AddProduct extends StatefulWidget
{
  @override
  State<AddProduct> createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct>
{
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _qty = TextEditingController();
  bool isloading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Product"),
      ),
      body: (isloading)?Center(child: CircularProgressIndicator(),): SingleChildScrollView(
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

                          setState(() {
                            isloading=true;
                          });

                          var name  = _name.text.toString();
                          var qty  = _qty.text.toString();
                          var price  = _price.text.toString();
                          
                          Uri url = Uri.parse("https://studiogo.tech/student/studentapi/insertProductNormal.php");

                          var params = {
                            "pname":name,
                            "qty":qty,
                            "price":price
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
                                  var message = json["message"].toString();
                                  _name.text = "";
                                  _qty.text = "";
                                  _price.text = "";
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(message,style: TextStyle(color: Colors.white),),
                                      backgroundColor: Colors.green,
                                    )
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
                        child: Text("Add"),
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
