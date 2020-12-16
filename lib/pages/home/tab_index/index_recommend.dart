import 'package:flutter/material.dart';
import 'package:hook_rent/pages/home/tab_index/index_recommend_data.dart';
import 'package:hook_rent/pages/home/tab_index/index_recommend_widget.dart';

class IndexRecommend extends StatelessWidget {
  final List<IndexRecommendItem> dataList;

  const IndexRecommend({Key key, this.dataList = IndexRecommendItemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:10.0,horizontal:10.0),
      decoration: BoxDecoration(
        color:Colors.grey[100],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '房屋推荐',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '更多',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0,),
          Wrap(
            spacing: 10.0,
            runSpacing:10.0,
            children: dataList.map((item) => IndexRecommendWidget(item)).toList(),
          ),
        ],
      ),
    );
  }
}