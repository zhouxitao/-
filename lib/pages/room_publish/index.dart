import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hook_rent/model/community.dart';
import 'package:hook_rent/pages/scoped_model/auth.dart';
import 'package:hook_rent/utils/common_toast.dart';
import 'package:hook_rent/utils/dio_http.dart';
import 'package:hook_rent/utils/scoped_model_helper.dart';
import 'package:hook_rent/utils/string_is_null_or_empty.dart';
import 'package:hook_rent/utils/upload_images.dart';
import 'package:hook_rent/widgets/common_floating_action_button.dart';
import 'package:hook_rent/widgets/common_form_input.dart';
import 'package:hook_rent/widgets/common_form_radio.dart';
import 'package:hook_rent/widgets/common_form_select.dart';
import 'package:hook_rent/widgets/common_image_picker.dart';
import 'package:hook_rent/widgets/common_title.dart';
import 'package:hook_rent/widgets/room_appliance.dart';
import 'package:hook_rent/model/general_type.dart';

class RoomPublishPage extends StatefulWidget {
  const RoomPublishPage({Key key}) : super(key: key);

  @override
  _RoomPublishPageState createState() => _RoomPublishPageState();
}

class _RoomPublishPageState extends State<RoomPublishPage> {

  List<GeneralType> floorList = [];
  List<GeneralType> orientedList = [];
  List<GeneralType> roomTypeList = [];

  int rentType=0;
  int decorateType=0;
  int roomType = 0;
  int floor = 0;
  int oriented = 0;

  List<File> images = [];

  Community community;

  List<RoomApplianceItem> applianceList=[];

  var titleController = TextEditingController();
  var descController = TextEditingController();

  var sizeController = TextEditingController();
  var priceController = TextEditingController();

  _getData()async{
    var url = '/houses/params';
    var res = await DioHttp.of(context).get(url);
    var resData = json.decode(res.toString())['body'];
    // print('房源发布信息--获取--$resData');

    List<GeneralType> floorList=List<GeneralType>.from(resData['floor'].map((item)=>GeneralType.fromJson(item))).toList();

    List<GeneralType> orientedList = List<GeneralType>.from(resData['oriented'].map((json)=>GeneralType.fromJson(json))).toList();

    List<GeneralType> roomTypeList = List<GeneralType>.from(resData['roomType'].map((json)=>GeneralType.fromJson(json))).toList();

    setState(() {
      this.floorList = floorList;
      this.orientedList = orientedList;
      this.roomTypeList = roomTypeList;
    });

  }

  @override
  void initState() {
    super.initState();

    Timer.run(_getData);
  }

  _onSubmit()async {
    var size = sizeController.text;
    var price = priceController.text;

    if(stringIsNullOrEmpty(size)){
      CommonToast.showToast('大小不能为空');
    }
    if(stringIsNullOrEmpty(price)){
      CommonToast.showToast('租金不能为空');
    }
    if(community == null){
      CommonToast.showToast('小区不能为空');
    }

    String url = '/user/houses';
    print('images----提交前--$images');
    var imageStr = await uploadImages(images, context);
    print('imageStr----提交---$imageStr');

    Map<String, dynamic> params = {
      "title":titleController.text,
      "description": descController.text,
      "price": price,
      "size": size,
      "oriented": orientedList[oriented].id,
      "roomType": roomTypeList[roomType].id,
      "floor":floorList[floor].id,
      "community": community.id,
      "houseImg": imageStr,//多条以 ｜ 分割
      "supporting": applianceList.map((e) => e.title).toList().join('|'),//多条以 ｜ 分割
    };

    var token = ScopedModelHelper.getModel<AuthModel>(context).token;

    var res = await DioHttp.of(context).post(url,params,token);

    print('发布房源---$res');
    var status = json.decode(res.toString())['status'];
    if(status.toString().startsWith('2')){
      CommonToast.showToast('房源发布成功');

      bool isSubmit = true;
      Navigator.of(context).pop(isSubmit);
    }else{
      var desc = json.decode(res.toString())['description'];
      CommonToast.showToast(desc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CommonFloatActionBtn(
        '发布',
        (context){
          _onSubmit();
        }
      ),
      appBar: AppBar(
        title: Text('房源发布'),
      ),
      body: ListView(
        children: [
          CommonTitle('房源信息'),
          CommonFormIput(
            label: '小区',
            contentBuilder: (context){
              return Container(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    var res = Navigator.of(context).pushNamed('communityPicker');
                    res.then((value) {
                      if(value != null){
                        setState(() {
                          community = value;
                        });
                      }
                    });
                  },
                  child: Container(
                    height: 40.0,
                    width:MediaQuery.of(context).size.width - 130.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          community?.name??'请选择小区',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
           CommonFormIput(
            label: '租金',
            hintText: '请输入租金',
            suffixText: '元/月',
            controller: priceController,
          ),
          CommonFormIput(
            label: '大小',
            hintText: '请输入房屋大小',
            suffixText: '平方米',
            controller: sizeController,
          ),
          CommonFormRadio(
            label: '租赁方式',
            options: ['合租','整租'],
            onChange: (index){
              setState(() {
                rentType  = index;
              });
            },
            value: rentType,
          ),

          if (roomTypeList.length>0) //****优化
          CommonFormSelect(
            label: '户型',
            options: roomTypeList.map((e) => e.name).toList(),
            value: roomType,
            onChange: (index){
              setState(() {
                roomType  = index;
              });
            },
          ),

          if (floorList.length>0) //****优化
          CommonFormSelect(
            label: '楼层',
            value: floor,
            options: floorList.map((e) => e.name).toList(),
            onChange: (val){
              setState(() {
                floor  = val;
              });
            },
          ),

          if (orientedList.length>0) //****优化
          CommonFormSelect(
            label: '朝向',
            value: oriented,
            options: orientedList.map((e) => e.name).toList(),
            onChange: (val){
              setState(() {
                oriented  = val;
              });
            },
          ),
          CommonFormRadio(
            label: '装修',
            options: ['精装','简装'],
            onChange: (index){
              setState(() {
                decorateType  = index;
              });
            },
            value: decorateType,
          ),
          CommonTitle('房源图片'),
          CommonImagePicker(
            onChange: (List<File> files){
              setState(() {
                images = files;
                // print('files--发布--$files');
              });
            },
          ),
          CommonTitle('房源标题'),
          Container(
            padding: EdgeInsets.symmetric(horizontal:10.0),
            child: TextField(
              controller: titleController,
              maxLines: 1,
              decoration: InputDecoration(
                // labelText: '房源标题',
                hintText: '请输入标题（例如：整组，小区名 2室 2000元）',
              ),
            ),
          ),
          CommonTitle('房源配置'),
          RoomAppliance(
            onChange: (list){
              applianceList = list;
            },
          ),
          CommonTitle('房源描述'),
          Container(
            margin: EdgeInsets.only(bottom: 100.0),
            padding: EdgeInsets.symmetric(horizontal:10.0),
            child: TextField(
              controller: descController,
              maxLines: 2,
              decoration: InputDecoration(
                // labelText: '房源描述',
                hintText: '请输入房屋描述信息',
              ),
            ),
          ),
        ],
      ),
    );
  }
}