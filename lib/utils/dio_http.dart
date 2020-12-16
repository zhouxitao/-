import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hook_rent/config.dart';
import 'package:hook_rent/config/routes.dart';
// import 'package:hook_rent/loading.dart';
import 'package:hook_rent/pages/scoped_model/auth.dart';
import 'package:hook_rent/utils/common_toast.dart';
import 'package:hook_rent/utils/scoped_model_helper.dart';
// import 'package:scoped_model/scoped_model.dart';


class DioHttp {

  Dio _client;
  BuildContext context;

  static DioHttp of(BuildContext context){
    return DioHttp._internal(context);
  }

  DioHttp._internal(BuildContext context){
    if(_client == null || context != this.context){
      this.context = context;
      var options = BaseOptions(
        baseUrl: Config.BaseUrl,
        connectTimeout: 1000 * 5,
        // receiveTimeout: 1000*3,
        extra: {'context':context},
      );

      Interceptor interceptor = InterceptorsWrapper(
        onResponse:(Response res) async {

          // print('interceptor----res---$res');
          if(res == null)return res;
          var status = json.decode(res.toString())['status'];
          // print('interceptor----status---$status');
          if(status == 404) {
            CommonToast.showToast('请求拦截--接口错误！当前接口--${res.request.path}');
          }
          if(status.toString().startsWith('4')){
            ScopedModelHelper.getModel<AuthModel>(context).logout();
            // print('interceptor----status---$status.toString()');
            // print(ModalRoute.of(context).settings.name);
            // print(Routes.loading);
            if(ModalRoute.of(context).settings.name == Routes.loading){
              return res;
            }

            CommonToast.showToast('登陆过期');
            Navigator.of(context).pushNamed(Routes.login);
            return res;
          }
        },
        onError: (DioError e) async {
          // 当请求失败时做一些预处理
        return e;//continue
        }
      );
      var client = Dio(options);
      client.interceptors.add(interceptor);
      this._client= client;
    }
  }

  Future<Response<Map<String, dynamic>>> get(String path,
    [Map<String, dynamic> params, String token]) async {
      var options = Options(
        headers: {
          "Authorization":token
        }
      );
      return await _client.get(
        path,
        queryParameters: params,
        options: options,
      );
    }

  Future<Response<Map<String, dynamic>>> post(String path,
    [Map<String, dynamic> params, String token]) async {
      var options = Options(
        headers: {
          "Authorization":token
        }
      );
      return await _client.post(
        path,
        data: params,
        options: options,
      );
    }

  Future<Response<Map<String, dynamic>>> postFormData(String path,
    [params, String token]) async {
      var options = Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          "Authorization":token,
        },
      );
      return await _client.post(
        path,
        data: params,
        options: options,
      );
    }

}