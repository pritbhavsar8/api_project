import 'package:api_project/models/Product.dart';
import 'package:flutter/material.dart';

class FakeProductDetails extends StatefulWidget {

  Product obj;
  FakeProductDetails({required this.obj});

  @override
  State<FakeProductDetails> createState() => _FakeProductDetailsState();
}

class _FakeProductDetailsState extends State<FakeProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.obj.image.toString()),
            Text(widget.obj.title.toString()),
            Text(widget.obj.description.toString()),
          ],
        ),
      ),
    );
  }
}
