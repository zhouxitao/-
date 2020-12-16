import 'package:flutter/material.dart';
import 'package:hook_rent/pages/home/info/index.dart';
import 'package:hook_rent/widgets/search_bar/index.dart';

class TabInfoPage extends StatefulWidget {

  TabInfoPage({Key key}) : super(key: key);

  @override
  _TabInfoPageState createState() => _TabInfoPageState();
}

class _TabInfoPageState extends State<TabInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness:Brightness.light,
        backgroundColor: Colors.white,
        title: SearchBar(
          onSearch: () {
            Navigator.of(context).pushNamed('search');
          },
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top:10.0),
            ),
            Info(),
            Info(),
            Info(),
          ],
        ),
      ),
    );
  }
}