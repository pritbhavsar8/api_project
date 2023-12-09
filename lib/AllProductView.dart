
import 'package:flutter/material.dart';

import 'models/AllProduct.dart';

class AllProductView extends StatefulWidget
{
  AllProduct obj;
  AllProductView({required this.obj});

  @override
  State<AllProductView> createState() => _AllProductViewState();
}

class _AllProductViewState extends State<AllProductView>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AllProductView"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(widget.obj.pid.toString()),
            Text(widget.obj.pname.toString()),
            Text(widget.obj.qty.toString()),
            Text(widget.obj.price.toString()),
            Text(widget.obj.addedDatetime.toString()),
          ],
        ),
      ),
    );
  }
}
