import 'package:flutter/material.dart';

class FnBottomItem {
  final String imageUri;
  final String title;
  final Function onTapHandle;

  FnBottomItem(this.imageUri, this.title, this.onTapHandle);
}

final List<FnBottomItem> list =[
  FnBottomItem('static/images/home_profile_record.png', '看房记录', null),
  FnBottomItem('static/images/home_profile_order.png', '我的订单', null),
  FnBottomItem('static/images/home_profile_favor.png', '我的收藏', null),
  FnBottomItem('static/images/home_profile_id.png', '身份认证', null),
  FnBottomItem('static/images/home_profile_message.png', '联系我们', null),
  FnBottomItem('static/images/home_profile_contract.png', '电子合同', null),
  FnBottomItem('static/images/home_profile_house.png', '房屋管理', (context) {
    bool isLogin = true; //todo:
    if (isLogin) {
      Navigator.pushNamed(context, 'roomManage');
      return;
    }
    Navigator.pushNamed(context, 'login');
  }),
  FnBottomItem('static/images/home_profile_wallet.png', '钱包', null),
];