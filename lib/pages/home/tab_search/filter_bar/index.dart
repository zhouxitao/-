import 'dart:async';
import 'dart:convert';

// import 'package:city_pickers/meta/_province.dart';
// import 'package:dio/src/response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hook_rent/pages/home/tab_search/filter_bar/data.dart';
import 'package:hook_rent/pages/home/tab_search/filter_bar/item.dart';
// import 'package:hook_rent/pages/scoped_model/city.dart';
import 'package:hook_rent/pages/scoped_model/room_filter.dart';
import 'package:hook_rent/utils/common_picker.dart';
import 'package:hook_rent/utils/dio_http.dart';
import 'package:hook_rent/utils/scoped_model_helper.dart';
import 'package:hook_rent/model/general_type.dart';
// import 'package:scoped_model/scoped_model.dart';

String lastCityId;

class FilterBarWidget extends StatefulWidget {

  final ValueChanged<FilterBarResult> onChange;

  const FilterBarWidget({Key key, this.onChange}) : super(key: key);

  @override
  _FilterBarWidgetState createState() => _FilterBarWidgetState();
}

class _FilterBarWidgetState extends State<FilterBarWidget> {
  String areaTitle='区域';
  bool isAreaActive = false;
  String rentTypeTitle='方式';
  bool isRentTypeActive = false;
  String priceTitle='租金';
  bool isPriceActive = false;
  bool isFilterActive = false;

  String areaId = '';
  String rentTypeId = '';
  String priceId = '';
  List<String> moreIds = [];


  List<GeneralType> areaList = [];
  List<GeneralType> priceList = [];
  List<GeneralType> rentTypeList = [];
  List<GeneralType> roomTypeList = [];
  List<GeneralType> orientedList = [];
  List<GeneralType> floorList = [];

  _areaChange(context){
    setState(() {
      isAreaActive = true;
    });

    var res = CommonPicker.showPicker(
      context: context,
      value: 0,
      options: areaList.map((item) => item.name).toList(),
    );

    res.then((index){
      if(index == null)return;
      setState(() {
        areaId = areaList[index].id;
        areaTitle=areaList[index].name;
      });
      _onChange();
    }).whenComplete(() => {
      isAreaActive = false
    });
  }

  _rentTypeChange(context){
    setState(() {
      isRentTypeActive = true;
    });

    var res = CommonPicker.showPicker(
      context: context,
      value: 0,
      options: rentTypeList.map((item) => item.name).toList(),
    );

    res.then((index){
      if(index == null)return;
      setState(() {
        rentTypeId = rentTypeList[index].id;
        rentTypeTitle=rentTypeList[index].name;
      });
      _onChange();
    }).whenComplete(() => {
      isRentTypeActive = false
    });
  }
    _priceChange(context){
    setState(() {
      isRentTypeActive = true;
    });

    var res = CommonPicker.showPicker(
      context: context,
      value: 0,
      options: priceList.map((item) => item.name).toList(),
    );

    res.then((index){
      if(index == null)return;
      setState(() {
        priceId = priceList[index].id;
        priceTitle=priceList[index].name;
      });
      _onChange();
    }).whenComplete(() => {
      isPriceActive = false
    });
  }
    _filterChange(context){
      Scaffold.of(context).openEndDrawer();
  }

  _onChange(){
    var selectedList = ScopedModelHelper.getModel<FilterBarModel>(context).selectedList;

    if(widget.onChange != null) {
      widget.onChange(FilterBarResult(
        areaId: areaId,
        rentTypeId:rentTypeId,
        priceId:priceId,
        moreIds: selectedList.toList(),
      ));
    }
  }

  // 获取数据
  _getData()async {

    var cityId = ScopedModelHelper.getAreaId(context);
    // print(cityId);
    lastCityId = cityId;

    String url = '/houses/condition?id=$cityId';
    Response<Map<String, dynamic>> res= await DioHttp.of(context).get(url);
    print('filterBar----$res');
    var data = json.decode(res.toString())['body'];
    // print(data);

    if(!this.mounted)return;//解决数据返回时，组件已卸载掉问题

    List<GeneralType> areaList = List<GeneralType>.from(data['area']['children'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> priceList = List<GeneralType>.from(data['price'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> rentTypeList = List<GeneralType>.from(data['rentType'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> roomTypeList = List<GeneralType>.from(data['roomType'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> orientedList = List<GeneralType>.from(data['oriented'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> floorList = List<GeneralType>.from(data['floor'].map((item) => GeneralType.fromJson(item)).toList());

    setState(() {
      this.areaList = areaList;
      this.priceList = priceList;
      this.rentTypeList = rentTypeList;
      this.roomTypeList = roomTypeList;
      this.orientedList = orientedList;
      this.floorList = floorList;
    });

    Map<String, List<GeneralType>> dataList = Map<String, List<GeneralType>>();
    dataList['roomTypeList'] = roomTypeList;
    dataList['orientedList'] = orientedList;
    dataList['floorList'] = floorList;
    ScopedModelHelper.getModel<FilterBarModel>(context).dataList = dataList;

    // print(dataList);
  }

  @override
  void initState() {
    super.initState();

    Timer.run(_getData);
  }

  @override
  void didChangeDependencies() {
    _onChange();
    if(lastCityId != null && ScopedModelHelper.getAreaId(context)!=lastCityId){
      _getData();
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1.0
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ItemWidget(
            title: areaTitle,
            isActive: isAreaActive,
            onTap: (context){
              _areaChange(context);
            },
          ),
          ItemWidget(
            title: rentTypeTitle,
            isActive: isRentTypeActive,
            onTap: _rentTypeChange,
          ),
          ItemWidget(
            title: priceTitle,
            isActive: isPriceActive,
            onTap: _priceChange,
          ),
          ItemWidget(
            title: '筛选',
            isActive: isFilterActive,
            onTap: _filterChange,
          ),
        ],
      ),
    );
  }
}
