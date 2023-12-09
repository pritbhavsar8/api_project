import 'package:flutter/material.dart';

import 'models/AllEmploye.dart';

class EmployeViewWithModel extends StatefulWidget
{
  AllEmploye obj;
  EmployeViewWithModel({required this.obj});
  @override
  State<EmployeViewWithModel> createState() => _EmployeViewWithModelState();
}

class _EmployeViewWithModelState extends State<EmployeViewWithModel>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Column(
          children: [
            Text(widget.obj.eid.toString()),
            Text(widget.obj.ename.toString()),
            Text(widget.obj.salary.toString()),
            Text(widget.obj.department.toString()),
            Text(widget.obj.gender.toString()),
          ],
        ),
      ),
    );
  }
}
