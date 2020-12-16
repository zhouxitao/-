import 'package:flutter/material.dart';
// import 'package:flutter_advanced_networkimage/provider.dart';
// import 'package:flutter_advanced_networkimage/transition.dart';
// import 'package:flutter_advanced_networkimage/zoomable.dart';


final networkUriReg=RegExp('^http');
final localUriReg=RegExp('^static');

class CommonImage extends StatelessWidget {
  final String src;
  final double height;
  final double width;
  final BoxFit fit;

  const CommonImage(this.src,{Key key,  this.height, this.width, this.fit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(networkUriReg.hasMatch(src)){
      return Image.network(
        src,
        height: height,
        width: width,
        fit: fit,
      );
      //   return Image(
      //   width: width,
      //   height: height,
      //   fit:fit,
      //   image: AdvancedNetworkImage(
      //     src,
      //     useDiskCache:true,
      //     cacheRule: CacheRule(maxAge: Duration(days: 7)),
      //     timeoutDuration: Duration(seconds: 20),
      //   ),
      // );
    }

    if(localUriReg.hasMatch(src)){
      return Image.asset(
        src,
        height: height,
        width: width,
        fit: fit,
      );
    }

    assert(false,'assert-不合法');
    return Container();
  }
}