import 'package:flutter/material.dart';
import 'package:hook_rent/config.dart';
import 'package:hook_rent/pages/scoped_model/auth.dart';
import 'package:hook_rent/utils/scoped_model_helper.dart';

var loginRegisterStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white
);
class HearderList extends StatelessWidget {
  const HearderList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _isLogin = ScopedModelHelper.getModel<AuthModel>(context).isLogin;
    // var _isLogin = true;

    print('isLogin---$_isLogin');
    return _isLogin?_loginBuilder(context):_notLoginBuilder(context);
  }

  Widget _notLoginBuilder(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.green[400]
      ),
      height: 95.0,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right:10.0),
            height: 65.0,
            width: 65.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://tva1.sinaimg.cn/large/006y8mN6ly1g6tbgbqv2nj30i20i2wen.jpg",
              ),

            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed('login');
                    },
                    child: Text(
                      '登陆',
                      style: loginRegisterStyle,
                    ),
                  ),
                  Text(
                    ' / ',
                    style: loginRegisterStyle,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed('register');
                    },
                    child: Text(
                      '注册',
                      style: loginRegisterStyle,
                    ),
                  ),
                ],
              ),
              Text(
                '登陆后可以体验更多',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _loginBuilder(BuildContext context) {
    var userInfo = ScopedModelHelper.getModel<AuthModel>(context).userInfo;
    print('userInfo---$userInfo');
    String userName = userInfo?.nickname??'已登陆用户名';
    String userImage = userInfo?.avatar??
        "https://tva1.sinaimg.cn/large/006y8mN6ly1g6tbnovh8jj30hr0hrq3l.jpg";

    if(!userImage.startsWith('http')){
      userImage = Config.BaseUrl + userImage;
    }
    // print('$userImage----$userImage');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.green[400]
      ),
      height: 95.0,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right:10.0),
            height: 65.0,
            width: 65.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                userImage,
              ),

            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0.0),
              ),
              Text(
                userName,
                style: loginRegisterStyle,
              ),
              Text(
                '查看编辑个人资料',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}
