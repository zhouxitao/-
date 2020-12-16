import 'package:flutter/material.dart';

class CommonFormIput extends StatelessWidget {
  final String label;
  final Widget Function(BuildContext context) contentBuilder;

  final String suffixText;
  final Widget suffix;

  final String hintText;
  final ValueChanged onChanged;
  final TextEditingController controller;

  const CommonFormIput({Key key, this.label, this.contentBuilder, this.suffixText, this.suffix, this.hintText, this.onChanged, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Theme.of(context).dividerColor,
          ),
        )
      ),
      child: Row(
        children: [
          Container(
            width: 100.0,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18.0
              ),
            ),
          ),
          Expanded(
            child: contentBuilder != null ?contentBuilder(context):TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(),
                border: InputBorder.none
              ),
              onChanged: onChanged,
            ),
          ),
          if(suffix!=null)suffix,
          if(suffix==null && suffixText != null )Text(suffixText)
        ],
      ),
    );
  }
}