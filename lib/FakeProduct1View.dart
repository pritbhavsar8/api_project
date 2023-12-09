import 'package:flutter/material.dart';

class FakeProductView extends StatefulWidget
{
  var title = "";
  var subtitle = "";
  var img = "";
  var rate = "";
  FakeProductView({required this.title,required this.subtitle,required this.img,required this.rate});

  @override
  State<FakeProductView> createState() => _FakeProductViewState();
}

class _FakeProductViewState extends State<FakeProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FakeProduct View"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(15),
              child: Image.network(widget.img,width: 400.0,height: 400.0,),
            ),
            Text(widget.title),
            Text("Price: " + widget.subtitle),
            Text(("Rate: " + widget.rate),
            ),
          ],
        ),
      ),
    );
  }
}
