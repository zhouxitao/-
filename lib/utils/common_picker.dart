import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CommonPicker {
  static Future<int> showPicker ({
    BuildContext context,
    List<String> options,
    int value,
    double height=300
  }){
    return showCupertinoModalPopup<int>(
      context:context,
      builder: (BuildContext context){

        var buttonTextStyle = TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        );

        var controller = FixedExtentScrollController(initialItem: value);

        return Container(
          color: Colors.grey,
          height: height,
          child: Column(
            children: [
              Container(
                color: Colors.grey[200],
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '取消',
                        style: buttonTextStyle,
                        ),
                    ),
                    FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop(controller.selectedItem);
                      },
                      child: Text(
                        '确定',
                        style: buttonTextStyle,
                        ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: controller,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  itemExtent:32.0,
                  onSelectedItemChanged: (val){},
                  children: options.map((item) => Text(item)).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}