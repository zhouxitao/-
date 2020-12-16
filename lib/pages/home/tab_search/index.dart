import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hook_rent/model/room_list_item_data.dart';
// import 'package:hook_rent/pages/home/tab_search/data_list.dart';
import 'package:hook_rent/pages/home/tab_search/filter_bar/data.dart';
import 'package:hook_rent/pages/home/tab_search/filter_bar/filter_drawer.dart';
import 'package:hook_rent/pages/home/tab_search/filter_bar/index.dart';
import 'package:hook_rent/utils/dio_http.dart';
import 'package:hook_rent/utils/scoped_model_helper.dart';
import 'package:hook_rent/widgets/room_list_item_widget.dart';
import 'package:hook_rent/widgets/search_bar/index.dart';

class TabSearchPage extends StatefulWidget {
  TabSearchPage({Key key}) : super(key: key);

  @override
  _TabSearchPageState createState() => _TabSearchPageState();
}

class _TabSearchPageState extends State<TabSearchPage> {

  List<RoomListItemData> list = [];

  _onFilterBarChange(FilterBarResult data) async {
    var cityId = ScopedModelHelper.getAreaId(context);
    var area=Uri.encodeQueryComponent(data.areaId);
    var mode=Uri.encodeQueryComponent(data.rentTypeId);
    var price=Uri.encodeQueryComponent(data.priceId);
    var more=Uri.encodeQueryComponent(data.moreIds.join(','));
    String url='/houses?cityId=$cityId&area=$area&mode=$mode&price=$price&more=$more&start=1&end=20';
    var res = await DioHttp.of(context).get(url);
    print('搜索列表---$res');
    List dataMap = json.decode(res.toString())['body']['list'];
    // print("dataMap-----$dataMap");

    List<RoomListItemData> resList = dataMap.map((e) => RoomListItemData.fromJson(e)).toList();

    setState(() {
      list = resList;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: FilterDrawer(),
      appBar: AppBar(
        brightness:Brightness.light,
        backgroundColor: Colors.white,
        title: SearchBar(
          isShowLocation: true,
          isShowMap: true,
          onSearch: (){
            Navigator.of(context).pushNamed('search');
          },
        ),
        elevation: 0.0,
        actions: [Container()], // 去掉appBar右侧的drawer图标
      ),
      body: Column(
        children:[
          FilterBarWidget(
            onChange:_onFilterBarChange,
          ),
          Expanded(
            child: ListView(
              children: list.map((item) => RoomListItemWidget(item)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}