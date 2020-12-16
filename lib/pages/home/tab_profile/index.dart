import 'package:flutter/material.dart';
import 'package:hook_rent/pages/home/info/index.dart';
import 'package:hook_rent/pages/home/tab_profile/ad.dart';
import 'package:hook_rent/pages/home/tab_profile/fn_bottom.dart';
import 'package:hook_rent/pages/home/tab_profile/hearder.dart';

class TabProfilePage extends StatelessWidget {
  const TabProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              Navigator.of(context).pushNamed('settings');
            },
          )
        ],
      ),
      body: ListView(
        children: [
          HearderList(),
          FnBottomList(),
          AdWidget(),
          Info(
            isShowTitle: true,
          ),
        ],
      ),
    );
  }
}