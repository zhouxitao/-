import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hook_rent/model/user_info.dart';
import 'package:hook_rent/utils/dio_http.dart';
import 'package:hook_rent/utils/store.dart';
import 'package:hook_rent/utils/string_is_null_or_empty.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthModel extends Model {
  String _token='';
  UserInfo _userInfo;

  String get token => _token;
  UserInfo get userInfo => _userInfo;

  bool get isLogin => _token is String && _token != '';

  void initApp(BuildContext context)async {
    Store  store  = await Store.getInstance();
    String token = await store.getString(StoreKeys.token);

    if(!stringIsNullOrEmpty(token)){
      login(token,context);
    }
  }

  _getUserInfo(BuildContext context) async{
    const url = '/user';
    var res = await DioHttp.of(context).get(url,null,_token);
    print('用户信息---auto.dart---$res');
    var resStr = json.decode(res.toString());
    var data = resStr['body'];

    if(data!=null)_userInfo = UserInfo.fromJson(data);//做报错处理
    notifyListeners();
  }

  void login(String token,BuildContext context){
    _token = token;

    _getUserInfo(context);
    notifyListeners();
  }

  void logout(){
    _token = '';
    notifyListeners();
  }
}