import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hook_rent/widgets/common_image.dart';

const List<String> defautImages = [
'http://ww3.sinaimg.cn/large/006y8mN6ly1g6e2tdgve1j30ku0bsn75.jpg',
'http://ww3.sinaimg.cn/large/006y8mN6ly1g6e2whp87sj30ku0bstec.jpg',
'http://ww3.sinaimg.cn/large/006y8mN6ly1g6e2tl1v3bj30ku0bs77z.jpg'
];

var imageWidth=750.0;
var imageHeight=424.0;

// ignore: must_be_immutable
class CommonSwiperWiget extends StatelessWidget {
    List<String> images;
    CommonSwiperWiget({Key key,this.images=defautImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width/imageWidth)*imageHeight,
      child: Swiper(
        itemCount: images.length,
        autoplay: true,
        itemBuilder:(BuildContext context, int index){
          return CommonImage(
            images[index],
            fit: BoxFit.fill,
          );
        },
        pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}