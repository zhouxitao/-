import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hook_rent/pages/not_found/index.dart';
import './routes_handlers.dart';

class Routes {
  // "/"代表首页是哪里
  // static String root = "/";
  static String home = "/";
  static String login = "/login";
  static String register = "/register";
  static String roomDetail = '/roomDetail/:roomId';
  static String settings = '/settings';
  static String roomManage = '/roomManage';
  static String roomPublish = '/roomPublish';
  static String communityPicker = '/communityPicker';
  static String loading = '/loading';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return NotFoundPage();
    });
    router.define(home, handler: homeHandler);
    router.define(login, handler: loginHandler);
    router.define(register, handler: registerHandler);
    router.define(roomDetail, handler: roomDetailHandler);
    router.define(settings, handler: settingHandler);
    router.define(roomManage, handler: roomManageHandler);
    router.define(roomPublish, handler: roomPublishHandler);
    router.define(communityPicker, handler: communityPickerHandler);

    router.define(loading, handler: loadingHandler);

  }
}