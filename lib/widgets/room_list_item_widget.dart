import 'package:flutter/material.dart';
import 'package:hook_rent/config.dart';
import 'package:hook_rent/model/room_list_item_data.dart';
// import 'package:hook_rent/pages/home/tab_search/data_list.dart';
import 'package:hook_rent/widgets/common_image.dart';
import 'package:hook_rent/widgets/common_tag.dart';

class RoomListItemWidget extends StatelessWidget {

  final RoomListItemData data;

  const RoomListItemWidget(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUri = data.imageUri.startsWith('http')?data.imageUri:Config.BaseUrl+data.imageUri;

    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('/roomDetail/${data.id}');
      },
      child: Container(
        padding: EdgeInsets.only(top:10.0,left:10.0,right: 10.0),
        child: Row(
          children: [
            CommonImage(
              imageUri,
              width: 132.5,
              height: 90.0,
            ),
            SizedBox(width: 10.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    data.subTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Wrap(
                    children: data.tags.map((item) => CommonTag(item)).toList(),
                  ),
                  Text(
                    '${data.price}元/月',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}