import 'package:flutter/material.dart';
import 'package:hook_rent/widgets/common_image.dart';

class AdWidget extends StatelessWidget {
  const AdWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
      child: CommonImage('https://tva1.sinaimg.cn/large/006y8mN6ly1g6te62n8f4j30j603vgou.jpg'),
    );
  }
}