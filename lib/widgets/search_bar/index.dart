import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:hook_rent/config.dart';
import 'package:hook_rent/model/general_type.dart';
import 'package:hook_rent/pages/scoped_model/city.dart';
import 'package:hook_rent/utils/common_toast.dart';
import 'package:hook_rent/utils/scoped_model_helper.dart';
import 'package:hook_rent/utils/store.dart';
import 'package:hook_rent/utils/string_is_null_or_empty.dart';

class SearchBar extends StatefulWidget {
  final bool isShowLocation;
  final Function goBackCallback;
  final String inputValue;
  final String defaultInputValue;
  final Function onCancel;
  final bool isShowMap;
  final Function onSearch;
  final ValueChanged<String> onSearchSubmit;

  SearchBar({
    Key key,
    this.isShowLocation,
    this.goBackCallback,
    this.inputValue,
    this.defaultInputValue='请输入KJLKSJDFH',
    this.onCancel,
    this.isShowMap,
    this.onSearch,
    this.onSearchSubmit
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  String _searchWord = '';
  TextEditingController _controller;
  FocusNode _focus;

  _onClean(){
    _controller.clear();
    setState(() {
      _searchWord='';
    });
  }

  _getCity()async {
    var store = await Store.getInstance();
    var cityStr = await store.getString(StoreKeys.city);

    if(cityStr == null)return;

    var city = GeneralType.fromJson(json.decode(cityStr));
    ScopedModelHelper.getModel<CityModel>(context).city = city;
  }

  _changeLocation() async{
    Result result = await CityPickers.showCitiesSelector(
      context: context,
      theme: ThemeData(
        primaryColor: Colors.green
      )
    );
    // print('picker-----$result');

    String cityName = result?.cityName;
    if(stringIsNullOrEmpty(cityName))return;

    var city = Config.availableCitys.firstWhere(
      (item) => cityName.startsWith(item.name),
      orElse: (){
        CommonToast.showToast('该城市接口暂未开通！');
        return null;
      },
    );
    // if(city==null)return
    _saveCity(city);
  }

  _saveCity(GeneralType city) async {
    if(city == null)return;

    ScopedModelHelper.getModel<CityModel>(context).city=city;

    var store = await Store.getInstance();
    var cityStr = json.encode(city.toJson());

    store.setString(StoreKeys.city, cityStr);
  }

  @override
  void initState() {
    super.initState();

    _controller=TextEditingController(
      text: widget.inputValue
    );

    _focus=FocusNode();

  }

  @override
  Widget build(BuildContext context) {
    var city = ScopedModelHelper.getModel<CityModel>(context).city;
    if(city ==null){
      city = Config.availableCitys.first;
      _getCity();
    }

    return Container(
      child: Row(
         children: [
            if(widget.isShowLocation != null)Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: GestureDetector(
               onTap:(){
                 _changeLocation();
               },
               child: Row(
                 children: [
                    Icon(
                      Icons.room,
                      color: Colors.green,
                      size: 18.0,
                    ),
                    Text(
                      city.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0
                      ),
                    )
                  ],
                ),
              ),
            ),

            if(widget.goBackCallback != null)Padding(
                padding: EdgeInsets.only(right:10.0),
                child: GestureDetector(
                  onTap: widget.goBackCallback,
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.black87,
                  ),
              ),
            ),

            Expanded(
              child: Container(
                height: 34.0,
                margin: EdgeInsets.only(right:10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  // border: Border.all(
                  //   color: Colors.grey[400],
                  // ),
                  color: Colors.grey[100],
                ),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  controller: _controller,
                  focusNode: _focus,
                  onTap: (){
                    if(widget.onSearchSubmit == null){
                      _focus.unfocus();
                    }
                    if(widget.onSearch != null)widget.onSearch();
                  },
                  onSubmitted: widget.onSearchSubmit,
                  onChanged: (val){
                    setState(() {
                      _searchWord = val;
                    });
                  },
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                  decoration: InputDecoration(
                    // prefixIcon: Icon(
                    //   Icons.search,
                    //   size: 20.0,
                    //   color: Colors.grey,
                    // ),

                    icon: Padding(
                      padding: EdgeInsets.only(top:4.0,left:8.0),
                      child: Icon(
                        Icons.search,
                        size: 20.0,
                        color: Colors.grey,
                      ),
                    ),
                    hintText: '请输入搜索内容',
                    hintStyle: TextStyle(
                      color: Colors.grey
                    ),
                    contentPadding: EdgeInsets.only(
                      top:-2.0,
                      left: -5.0,
                    ),
                    border: InputBorder.none,
                    // disabledBorder: InputBorder.none,
                    suffixIcon: GestureDetector(
                      child: Icon(
                        Icons.clear,
                        size: 20.0,
                        color: _searchWord == ''?Colors.grey[200]:Colors.grey,
                      ),
                      onTap: (){
                        _onClean();
                      },
                    ),
                  ),
                ),
              ),
            ),

            if(widget.onCancel != null )Padding(
              padding: EdgeInsets.only(right:10.0),
              child: GestureDetector(
                onTap: widget.onCancel,
                child: Text(
                  '取消',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),

            if(widget.isShowMap != null)GestureDetector(
              onTap: (){},
              child: Image.asset(
                'static/icons/widget_search_bar_map.png',

              ),
              ),
          ],
       ),
    );
  }
}