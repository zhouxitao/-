import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hook_rent/model/community.dart';
import 'package:hook_rent/utils/dio_http.dart';
import 'package:hook_rent/utils/scoped_model_helper.dart';
import 'package:hook_rent/widgets/search_bar/index.dart';

class CommunityPicker extends StatefulWidget {
  CommunityPicker({Key key}) : super(key: key);

  @override
  _CommunityPickerState createState() => _CommunityPickerState();
}

class _CommunityPickerState extends State<CommunityPicker> {

  List<Community> dataList = [];

  _searchHandle(String value)async{
    var areaId = ScopedModelHelper.getAreaId(context);
    var url = '/area/community?name=$value&id=$areaId';
    var res = await DioHttp.of(context).get(url);

    var data = json.decode(res.toString())['body'];
    // print('小区查询$data');

    List<Community> resList = List<Community>.from(data.map((item)=>Community.fromJson(item)).toList());

    setState(() {
      dataList=resList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: SearchBar(
          onCancel: (){
            Navigator.of(context).pop();
          },
          goBackCallback: () {
            Navigator.of(context).pop();
          },
          onSearchSubmit: _searchHandle,
        ),

      ),
      body: SafeArea(
        minimum: EdgeInsets.all(10.0),
        child: ListView.separated(
          separatorBuilder: (_context, _) => Divider(),
          itemCount:dataList.length,
          itemBuilder: (context,index){
            return GestureDetector(
              behavior:HitTestBehavior.translucent,
              onTap: (){
                Navigator.of(context).pop(dataList[index]);
              },
              child:  Container(
                padding: EdgeInsets.all(5.0),
                child: Text(dataList[index].name),
              ),
            );
          },
        ),
      ),
    );
  }
}