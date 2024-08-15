import 'package:flutter/material.dart';

class MetinAlani extends StatelessWidget {
  const MetinAlani({
    super.key,
    required this.ipucuMetin,
    required this.maxLine,
    required this.metinDenetleyici,
  });
  final String ipucuMetin;
  final int maxLine;
  final TextEditingController metinDenetleyici;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8)),
        child: TextField(
          controller: metinDenetleyici,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: ipucuMetin,
          ),
          maxLines: maxLine,
        ));
  }
}
