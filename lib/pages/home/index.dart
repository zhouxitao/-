import 'package:flutter/material.dart';
import 'package:hook_rent/pages/home/tab_index/index.dart';
import 'package:hook_rent/pages/home/tab_info/index.dart';
import 'package:hook_rent/pages/home/tab_profile/index.dart';
import 'package:hook_rent/pages/home/tab_search/index.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 0;
  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _tabViewList = <Widget>[
    TabIndexPage(),
    TabSearchPage(),
    TabInfoPage(),
    TabProfilePage(),
  ];

  List<BottomNavigationBarItem> _tabItemList = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: '搜索'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat),
      label: '资讯'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: '我的'
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabViewList[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:_tabIndex,
        type: BottomNavigationBarType.fixed,
        items: _tabItemList,
        unselectedItemColor:Colors.grey,
        selectedItemColor: Colors.green,
        onTap: (index){
         _onItemTapped(index);
        },
      )
    );
  }
}
