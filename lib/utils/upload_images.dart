import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hook_rent/pages/scoped_model/auth.dart';
import 'package:hook_rent/utils/dio_http.dart';
import 'package:hook_rent/utils/scoped_model_helper.dart';

Future<String> uploadImages (List<File> files , BuildContext context )async {
  if(files == null) return Future.value('');

  if(files.length == 0)return Future.value('');

  var token = ScopedModelHelper.getModel<AuthModel>(context).token;

  var formData = FormData();
  for(int i = 0; i < files.length; i++) {
    formData.files.add(
      MapEntry(
        "file",
        await MultipartFile.fromFile(
            files[i].path.toString()
        )
      )
    );
  }
  String url = '/houses/image';
  var res= await DioHttp.of(context).postFormData(url,formData,token);

  var data = json.decode(res.toString())['body'];

  String images = List<String>.from(data).join('|');

  return Future.value(images);
}