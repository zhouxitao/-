import 'package:flutter/material.dart';
import 'package:hook_rent/pages/home/info/index.dart';
import 'package:hook_rent/pages/home/tab_index/index_navigator.dart';
import 'package:hook_rent/pages/home/tab_index/index_recommend.dart';
import 'package:hook_rent/widgets/common_swiper.dart';
import 'package:hook_rent/widgets/search_bar/index.dart';

class TabIndexPage extends StatelessWidget {
  const TabIndexPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: SearchBar(
          isShowLocation: true,
          isShowMap: true,
          onSearch: () {
            Navigator.of(context).pushNamed('search');
          },
        ),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          CommonSwiperWiget(),
          IndexNavigator(),
          IndexRecommend(),
          Info(
            isShowTitle: true,
          ),
        ],
      ),
    );
  }
}