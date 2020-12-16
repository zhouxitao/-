import 'package:flutter/material.dart';
import 'package:hook_rent/pages/home/tab_index/index_recommend_data.dart';
import 'package:hook_rent/widgets/common_image.dart';

var textStyle=TextStyle(fontSize: 14.0,fontWeight: FontWeight.w700);

class IndexRecommendWidget extends StatelessWidget {
  final IndexRecommendItem data;

  const IndexRecommendWidget(this.data,{Key key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(data.navigatorUrl);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        width: (MediaQuery.of(context).size.width-30.0)/2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  data.title,
                  style: textStyle
                ),
                Text(
                  data.subTitle,
                  style: textStyle
                )
              ],
            ),
            CommonImage(
              data.imageUrl,
              width: 55.0,
            )
          ],
        ),
      ),
    );
  }
}