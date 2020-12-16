// import 'package:flutter/painting.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hook_rent/loading.dart';
import 'package:hook_rent/pages/community_picker.dart';
import 'package:hook_rent/pages/home/index.dart';
import 'package:hook_rent/pages/login/index.dart';
import 'package:hook_rent/pages/login/register.dart';
import 'package:hook_rent/pages/not_found/index.dart';
import 'package:hook_rent/pages/room_detail/index.dart';
import 'package:hook_rent/pages/room_manage/index.dart';
import 'package:hook_rent/pages/room_publish/index.dart';
import 'package:hook_rent/pages/settings.dart';

var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

var registerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RegisterPage();
});

var notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return NotFoundPage();
});

var roomDetailHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return RoomDetailPage(roomId: params['roomId'][0],);
});

var settingHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SettingPage();
});

var roomManageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return RoomManagePage();
});

var roomPublishHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return RoomPublishPage();
});

var communityPickerHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return CommunityPicker();
});

var loadingHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return LoadingPage();
});