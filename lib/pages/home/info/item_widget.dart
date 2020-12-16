import 'package:flutter/material.dart';
import 'package:hook_rent/pages/home/info/data.dart';
import 'package:hook_rent/widgets/common_image.dart';

var textStyle =TextStyle(
  color: Colors.black45,
);

class InfoItemWidget extends StatelessWidget {
  final InfoItem data;

  const InfoItemWidget(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      padding: EdgeInsets.only(left:10.0,right:10.0,bottom: 10.0),
      child: Row(
        children: [
          CommonImage(
            data.imageUri,
            width: 120.0,
            height: 90.0,
          ),
          SizedBox(width: 10.0,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.source,
                      style: textStyle,
                    ),
                    Text(
                      data.time,
                      style: textStyle,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}