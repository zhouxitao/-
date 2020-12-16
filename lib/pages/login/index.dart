import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hook_rent/pages/scoped_model/auth.dart';
import 'package:hook_rent/utils/common_toast.dart';
import 'package:hook_rent/utils/dio_http.dart';
import 'package:hook_rent/utils/scoped_model_helper.dart';
import 'package:hook_rent/utils/store.dart';
import 'package:hook_rent/utils/string_is_null_or_empty.dart';
// import 'package:hook_rent/widgets/page_content.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isShowPWD = true;

  var _usernameController = TextEditingController();
  var _pwdController = TextEditingController();

  void _onLogin() async{
    String username =_usernameController.text;
    String password =_pwdController.text;

    if(stringIsNullOrEmpty(username) || stringIsNullOrEmpty(password)){
      CommonToast.showToast('用户名/密码不能为空');
    }

    const url ='/user/login';
    var data ={
      "username": username,
      "password": password
    };
    var res = await DioHttp.of(context).post(url,data);
    var resStr = json.decode(res.toString());

    print('登录---$resStr');
    String description = resStr['description']?? '内部错误';
    CommonToast.showToast(description);
    if(resStr['status']==200){
      String token = resStr['body']['token'];
      Store store = await Store.getInstance();
      await store.setString(StoreKeys.token, token);

      ScopedModelHelper.getModel<AuthModel>(context).login(token, context);

      Timer(Duration(seconds: 1), (){
        Navigator.of(context).pushReplacementNamed('/');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
        elevation: 0.0,
      ),
      body: SafeArea(
        minimum:EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: '用户名',
                hintText: '请输入用户名',
              ),
            ),
            SizedBox(height: 20.0,),
            TextField(
              obscureText:_isShowPWD,
              controller: _pwdController,
              decoration: InputDecoration(
                labelText: '密码',
                hintText: '请输入密码',
                suffixIcon: IconButton(
                  icon: Icon(
                  _isShowPWD?Icons.visibility_off:Icons.visibility,
                  ),
                  onPressed: (){
                    setState(() {
                      _isShowPWD = !_isShowPWD;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              color: Colors.green,
              onPressed: (){
                _onLogin();
              },
              child:  Text(
                '登录',
                style: TextStyle(
                  color:Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '还没有账号',
                  style: TextStyle(

                  ),
                ),
                FlatButton(
                  child: Text(
                    '去注册~',
                    style:TextStyle(
                      color: Colors.green
                    ),
                  ),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, 'register');
                  },
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}