import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function(BuildContext) onTap;

  const ItemWidget({
    Key key, this.title, this.isActive, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = isActive? Colors.green:Colors.black;

    return GestureDetector(
      onTap: (){
        if(onTap!=null){
          onTap(context);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              color: color,
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: color,
            size: 30.0,
          )
        ],
      ),
    );
  }
}