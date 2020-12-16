import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hook_rent/config.dart';
import 'package:hook_rent/model/room_detail_data.dart';
import 'package:hook_rent/pages/home/info/index.dart';
import 'package:hook_rent/pages/room_detail/data.dart';
import 'package:hook_rent/utils/dio_http.dart';
import 'package:hook_rent/widgets/common_swiper.dart';
import 'package:hook_rent/widgets/common_tag.dart';
import 'package:hook_rent/widgets/common_title.dart';
import 'package:hook_rent/widgets/room_appliance.dart';
import 'package:share/share.dart';


var _bottomTextBtnStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white
);

class RoomDetailPage extends StatefulWidget {
  final String roomId;

  const RoomDetailPage({Key key, this.roomId}) : super(key: key);

  @override
  _RoomDetailPageState createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {

  RoomDetailData data;
  bool isLike =false;
  bool isShowAllText = false;


  _getData()async {
    final url = '/houses/${widget.roomId}';
    var res = await DioHttp.of(context).get(url);
    var resMap = json.decode(res.toString());
    var resData = resMap['body'];
    var roomDetailData = RoomDetailData.fromJson(resData);

    // print(roomDetailData);
    roomDetailData.houseImgs = roomDetailData.houseImgs.map((e) => Config.BaseUrl + e).toList();

    setState(() {
      data = roomDetailData;
    });
  }

  @override
  void initState() {
    super.initState();
    data = defaultData;
    _getData();
  }

  @override
  Widget build(BuildContext context) {

    bool isShowExpandBtn = data.subTitle.length > 100;

    return data==null?Container():Scaffold(
      appBar: AppBar(
        title: Text(data.title),
        elevation: 0.0,
        actions: [
          IconButton(
            icon:Icon(Icons.share),
            onPressed: (){
              Share.share('http://dangdu.dangdang.com/book/153725.shtml');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              CommonSwiperWiget(images:data.houseImgs),
              CommonTitle(data.title),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      data.price.toString(),
                      style: TextStyle(
                        color:Colors.pink,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' 元/月(押一付三)',
                      style: TextStyle(
                        color:Colors.red,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical:6.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Wrap(
                  spacing: 4.0,
                  children: data.tags.map((e) => CommonTag(e)).toList(),
                ),
              ),
              Divider(
                // height: 10.0,
                color: Colors.grey,
                endIndent: 10.0,
                indent: 10.0,
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
                child: Wrap(
                  runSpacing: 20.0,
                  children: [
                    BaseInfoItem('面积: ${data.size}平米'),
                    BaseInfoItem('楼层: ${data.floor}'),
                    BaseInfoItem('户型: ${data.roomType}'),
                    BaseInfoItem('装修: 精装'),
                  ],
                ),
              ),
              CommonTitle("房屋配置"),
              RoomApplianceList(data.applicances),
              CommonTitle("房屋概况"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Text(
                      data.subTitle,
                      maxLines: isShowAllText?5:1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(

                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isShowExpandBtn?GestureDetector(
                          onTap: (){
                            setState(() {
                              isShowAllText = !isShowAllText;
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                isShowAllText?'已展开':'展开',
                              ),
                              Icon(
                                isShowAllText?Icons.arrow_drop_down:Icons.arrow_right,
                              ),
                            ],
                          ),
                        ):Container(),
                        Text(
                          '举报',
                          style: TextStyle(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              CommonTitle("猜你喜欢"),
              Info(),
              Container(
                height: 100.0,
              )
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              color: Colors.grey[200],
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isLike  = !isLike;
                      });
                    },
                    child: Container(
                      width: 60.0,
                      height: 50.0,
                      margin: EdgeInsets.only(right: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            isLike?Icons.star:Icons.star_border_outlined,
                            color: isLike?Colors.green:Colors.black87,
                            size: 24.0,
                          ),
                          Text(
                            isLike?'已收藏':'收藏',
                            style: TextStyle(
                              fontSize: 16.0
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: 50.0,
                        margin: EdgeInsets.only(right:10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.cyan,
                        ),
                        child: Center(
                          child: Text(
                            '联系房东',
                            style: _bottomTextBtnStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            '联系房东',
                            style: _bottomTextBtnStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BaseInfoItem extends StatelessWidget {
  final String content;
  const BaseInfoItem(this.content, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width-30.0)/2,
      child: Text(
        content,
        style:TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}