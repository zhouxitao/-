import 'package:flutter/material.dart';
import 'package:hook_rent/config/routes.dart';

class PageContent extends StatelessWidget {
  final String pageTitle;

  const PageContent({Key key, this.pageTitle }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        elevation: 0.0,
      ),
      body:ListView(
        children: [
          FlatButton(
            child: Text(Routes.login),
            onPressed: (){
             Navigator.pushNamed(context, Routes.login);
            },
          ),
          FlatButton(
            child: Text(Routes.home),
            onPressed: (){
              Navigator.pushNamed(context, Routes.home);
            },
          ),
          FlatButton(
            child: Text('fault'),
            onPressed: (){
              Navigator.pushNamed(context, '/ccc');
            },
          ),

          FlatButton(
            child: Text('详情id：222'),
            onPressed: (){
              Navigator.pushNamed(context, '/room/2222');
            },
          ),
        ],
      )
    );
  }
}