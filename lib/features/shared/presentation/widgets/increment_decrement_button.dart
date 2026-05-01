import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utils_extension.dart';

class InDecButton extends StatefulWidget {
  const InDecButton({
    super.key,
    required this.onChanged,
    this.initialValue,
    required this.maxValue,
  });

  final ValueChanged<int> onChanged;
  final int? initialValue;
  final int maxValue;

  @override
  State<InDecButton> createState() => _InDecButtonState();
}

class _InDecButtonState extends State<InDecButton> {

  int _counter = 1;

  @override
  void initState(){
    super.initState();
    if(widget.initialValue != null) _counter = widget.initialValue!;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      spacing: 5,
      mainAxisAlignment: .center,
      children: [
        InkWell(
          onTap: () {
            if(_counter > 1 ){
              setState(() {
                _counter--;
              });
              widget.onChanged(_counter);
            }
          },
          child: Container(
            height: 30,
            width: 36,
            decoration: BoxDecoration(
                color: AppColors.themeColor.withAlpha(100),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(Icons.remove, color: Colors.white,),
          ),
        ),
        Text('$_counter', style: context.textTheme.bodyLarge,),
        InkWell(
          onTap: () {
            if(_counter < widget.maxValue){
              setState(() {
                _counter++;
              });
              widget.onChanged(_counter);
            }
          },
          child: Container(
            height: 30,
            width: 36,
            decoration: BoxDecoration(
                color: AppColors.themeColor,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(Icons.add, color: Colors.white,),
          ),
        )
      ],
    );
  }
}