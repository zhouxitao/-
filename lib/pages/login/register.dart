import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hook_rent/utils/common_toast.dart';
import 'package:hook_rent/utils/dio_http.dart';
import 'package:hook_rent/utils/string_is_null_or_empty.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool _isShowPWD = true;
  bool _isShowConfirmPWD = true;
  var _usernameController = TextEditingController();
  var _pwdController = TextEditingController();
  var _confitmPwdController = TextEditingController();

  _onRegister()async {
    String username = _usernameController.text;
    String password = _pwdController.text;
    String confirmPassword = _confitmPwdController.text;
    print('$username--$password--$confirmPassword');

    if(password != confirmPassword){
      CommonToast.showToast('密码与确认密码不一致');
    }

    if(stringIsNullOrEmpty(username) || stringIsNullOrEmpty(password)){
      CommonToast.showToast('用户名/密码不能为空');
      return;
    }

    const url = '/user/registered';
    var params = {
      "username" :username,
      "password" : password,
    };

    var res = await DioHttp.of(context).post(url,params);
    var resString = json.decode(res.toString());
    print('$res--$resString');
    String description = resString['description'] ?? '内部错误';
    CommonToast.showToast(description);

    if(resString['status'] == 200){
      Navigator.of(context).pushReplacementNamed('login');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
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
              controller: _pwdController,
              obscureText:_isShowPWD,
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
            TextField(
              controller: _confitmPwdController,
              obscureText:_isShowConfirmPWD,
              decoration: InputDecoration(
                labelText: '确认密码',
                hintText: '请输入确认密码',
                suffixIcon: IconButton(
                  icon: Icon(
                  _isShowConfirmPWD?Icons.visibility_off:Icons.visibility,
                  ),
                  onPressed: (){
                    setState(() {
                      _isShowConfirmPWD = !_isShowConfirmPWD;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              color: Colors.green,
              onPressed: (){
                 _onRegister();
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
                  '已有账号',
                  style: TextStyle(

                  ),
                ),
                FlatButton(
                  child: Text(
                    '去登录~',
                    style:TextStyle(
                      color: Colors.green
                    ),
                  ),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, 'login');
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