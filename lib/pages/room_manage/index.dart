import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:hook_rent/model/room_detail_data.dart';
import 'package:hook_rent/model/room_list_item_data.dart';
import 'package:hook_rent/pages/home/tab_search/data_list.dart';
import 'package:hook_rent/pages/scoped_model/auth.dart';
import 'package:hook_rent/utils/dio_http.dart';
import 'package:hook_rent/utils/scoped_model_helper.dart';
import 'package:hook_rent/widgets/common_floating_action_button.dart';
import 'package:hook_rent/widgets/room_list_item_widget.dart';

// var  _tabBarStyle = TextStyle(
//   fontSize: 16.0,
//   color: Colors.grey,
// );
class RoomManagePage extends StatefulWidget {
  final bool isSubmited;
  const RoomManagePage({Key key,this.isSubmited}) : super(key: key);

  @override
  _RoomManagePageState createState() => _RoomManagePageState();
}

class _RoomManagePageState extends State<RoomManagePage> {

  List<RoomListItemData> availableDataList=[];

  _getData() async {
    var auth = ScopedModelHelper.getModel<AuthModel>(context);
    if(!auth.isLogin)return;

    var token = auth.token;
    var url = '/user/houses';
    var res = await DioHttp.of(context).get(url,null,token);

    var resMap = json.decode(res.toString());
    // print('房屋管理$resMap');
    List listMap = resMap['body'];

    var dataList1 = listMap.map((item)=>
      RoomListItemData.fromJson(item)
    ).toList();
    // print('房屋管理--数据---$dataList');

    setState(() {
      availableDataList = dataList1;
    });
  }

  @override
  void initState() {
    super.initState();

    Timer.run(_getData);
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex:0,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CommonFloatActionBtn(
          '发布房源',
          (context){
            var res = Navigator.of(context).pushNamed('roomPublish');
            res.then((value){
              if(value)_getData();
            });
          }
        ),
        appBar: AppBar(
          title: Text('房屋管理'),
          elevation: 0.0,
          bottom: TabBar(
            tabs: [
              Text('空置'),
              Text('已租'),
            ],
            indicatorColor:Colors.blue[600],
            indicatorWeight : 6.0,
            labelStyle:TextStyle(
              fontSize: 18.0
            ),
            unselectedLabelStyle:TextStyle(
              fontSize: 16.0
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children:availableDataList.map((e) => RoomListItemWidget(e)).toList(),
            ),
            ListView(
              children: dataList.map((e) => RoomListItemWidget(e)).toList(),
            )
          ],
        )
      ),
    );
  }
}