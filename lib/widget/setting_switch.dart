import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SettingSwitch extends StatelessWidget {

  final String baslik;
  final Color bgcolor;
  final Color iconColor;
  final IconData icon;
  final Function(bool value) onTap;
  final bool value;
  const SettingSwitch({
    super.key,
    required this.baslik,
    required this.bgcolor,
    required this.iconColor,
    required this.icon,
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
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
          Text(
            value
            ? "On":"Off",
            style:const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

          const SizedBox(width: 20),
          CupertinoSwitch(value:value , onChanged: onTap ),

        ],
      ),
    );
  }
}
