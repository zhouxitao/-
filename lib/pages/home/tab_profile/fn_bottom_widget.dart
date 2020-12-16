import 'package:flutter/material.dart';
import 'package:hook_rent/pages/home/tab_profile/fn_bottom_data.dart';
import 'package:hook_rent/widgets/common_image.dart';

class FnBottomWidget extends StatelessWidget {
  final FnBottomItem data;

  const FnBottomWidget(this.data, {Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(data.onTapHandle != null){
          data.onTapHandle(context);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width/3,
        margin: EdgeInsets.only(top:30.0),
        child: Column(
          children: [
            CommonImage(data.imageUri),
            SizedBox(height: 10.0,),
            Text(data.title)
          ],
        ),
      ),
    );
  }
}