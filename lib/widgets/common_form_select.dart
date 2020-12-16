import 'package:flutter/material.dart';
import 'package:hook_rent/utils/common_picker.dart';
import 'package:hook_rent/widgets/common_form_input.dart';

class CommonFormSelect extends StatelessWidget {

  final String label;
  final int value;
  final List<String> options;
  final Function(int) onChange;

  const CommonFormSelect({Key key, this.label, this.value, this.options, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonFormIput(
      label: label,
      contentBuilder: (context){
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            var res = CommonPicker.showPicker(context: context, options: options, value: value);

            res.then((selectVal) => {
              if(value!=null && selectVal != null && onChange != null){
                onChange(selectVal)
              }
            });
          },
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  options[value],
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
          ),
        );
      },
    );
  }
}