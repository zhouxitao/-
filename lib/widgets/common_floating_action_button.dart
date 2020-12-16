import 'package:flutter/material.dart';

class CommonFloatActionBtn extends StatelessWidget {
  final String title;
  final Function onTap;
  const CommonFloatActionBtn(this.title, this.onTap,{Key key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(onTap != null){
          onTap(context);
        }
      },
      child: Container(
        height: 40.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}