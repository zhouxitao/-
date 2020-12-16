import 'package:flutter/material.dart';
import 'package:hook_rent/pages/home/info/data.dart';
import 'package:hook_rent/pages/home/info/item_widget.dart';

class Info extends StatelessWidget {
  final bool isShowTitle;
  final List<InfoItem> dataList;
  const Info({Key key,this.isShowTitle=false, this.dataList=infoData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(isShowTitle)Container(
            padding: EdgeInsets.only(left:10.0,bottom: 5.0),
            child: Text(
              '最新资讯',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Column(
            children: dataList.map((item) => InfoItemWidget(item)).toList(),
          ),
        ],
      ),
    );
  }
}