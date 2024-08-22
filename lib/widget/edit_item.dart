
import 'package:flutter/material.dart';

class EditItem extends StatelessWidget{
  final Widget widget;
  final String baslik;
  const EditItem({
    super.key,
    required this.widget,
    required this.baslik,
  });
  @override
  Widget build(BuildContext context){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Expanded(
          child: Text(
           baslik ,
            style:
           const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 4,
          child: widget,
        )
      ],
    );
  }
}
