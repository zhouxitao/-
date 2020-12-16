import 'package:flutter/material.dart';
import 'package:hook_rent/widgets/common_form_input.dart';

class CommonFormRadio extends StatelessWidget {

  final String label;
  final List<String> options;
  final int value;
  final ValueChanged<int> onChange;
  const CommonFormRadio({Key key, this.label, this.options, this.value, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonFormIput(
      label: label,
      contentBuilder: (context){
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              options.length,
              (index) => Row(
                children: [
                  Radio(
                    onChanged: onChange,
                    groupValue: value,
                    value: index,
                  ),
                  Text(
                    options[index]
                  )
                ],
              )
            ),
          ),
        );
      },
    );
  }
}