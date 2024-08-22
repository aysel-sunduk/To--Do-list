import 'package:flutter/material.dart';

import 'forward_button_widget.dart';

class SettingItem extends StatelessWidget{

  final String baslik;
  final Color bgcolor;
  final Color iconColor;
  final IconData icon;
  final Function() onTap;
  final String? value;
  const SettingItem({
    super.key,
    required this.baslik,
    required this.bgcolor,
    required this.iconColor,
    required this.icon,
    required this.onTap,
    this.value,
  });
  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgcolor,
            ),
            child: Icon(
                icon,
                color: iconColor,
            ),
          ),
          const SizedBox(width: 20),

           Text(
            baslik,
            style:const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          value!= null
          ?Text(
            value!,
            style:const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ): const SizedBox(),
          const SizedBox(width: 20),
          ForwardButton(
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}