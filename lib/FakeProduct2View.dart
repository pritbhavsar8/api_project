
import 'package:api_project/models/Product2.dart';
import 'package:flutter/material.dart';

class FakeProduct2View extends StatefulWidget
{
  Product2 obj;
  FakeProduct2View({required this.obj});

  @override
  State<FakeProduct2View> createState() => _FakeProduct2ViewState();
}

class _FakeProduct2ViewState extends State<FakeProduct2View>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FakeProduct2View"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.obj.images![1].toString(),width: 200,height: 200,),
            Text(widget.obj.title.toString()),
            Text(widget.obj.description.toString()),
            Text(widget.obj.price.toString()),

          ],
        ),
      ),
    );
  }
}
