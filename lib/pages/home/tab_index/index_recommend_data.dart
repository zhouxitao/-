class IndexRecommendItem {
  final String title;
  final String subTitle;
  final String imageUrl;
  final String navigatorUrl;

  const IndexRecommendItem(this.title,this.subTitle,this.imageUrl,this.navigatorUrl);
}

const List<IndexRecommendItem> IndexRecommendItemData =[
  const IndexRecommendItem(
    '家住回龙观',
    '归属的感觉',
    'static/images/home_index_recommend_1.png',
    'login'
  ),
  const IndexRecommendItem(
      '宜居四五环', '大都市生活','static/images/home_index_recommend_2.png', 'login'),
  const IndexRecommendItem(
      '喧嚣三里屯', '繁华的背后','static/images/home_index_recommend_3.png', 'login'),
  const IndexRecommendItem(
      '比邻十号线','地铁心连心', 'static/images/home_index_recommend_4.png', 'login'),
];