import 'package:flutter/material.dart';
import 'package:hook_rent/pages/home/tab_index/index_navigator_item.dart';
import 'package:hook_rent/widgets/common_image.dart';

class IndexNavigator extends StatelessWidget {
  const IndexNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: indexNavigatorItemList.map((item) =>
        InkWell(
          onTap: (){
            item.onTap(context);
          },
          child: Column(
            children: [
              CommonImage(
                item.imageUrl,
                width: 45.0,
              ),
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        )
      ).toList()
    );
  }
}