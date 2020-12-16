import 'package:flutter/material.dart';
import 'package:hook_rent/pages/home/tab_profile/fn_bottom_data.dart';
import 'package:hook_rent/pages/home/tab_profile/fn_bottom_widget.dart';

class FnBottomList extends StatefulWidget {
  FnBottomList({Key key}) : super(key: key);

  @override
  _FnBottomListState createState() => _FnBottomListState();
}

class _FnBottomListState extends State<FnBottomList> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: list.map((item)=>FnBottomWidget(item)).toList(),
    );
  }
}