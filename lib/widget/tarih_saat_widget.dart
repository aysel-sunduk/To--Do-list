import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../sabitler/app_style.dart';

class TarihSaatWidget extends ConsumerWidget {
  const TarihSaatWidget({
    super.key,
    required this.metinBasligi,
    required this.metinDegeri,
    required this.iconBolumu,
    required this.tiklayinca,
  });

  final String metinBasligi;
  final String metinDegeri;
  final IconData iconBolumu;
  final VoidCallback tiklayinca;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            metinBasligi,
            style: AppStyle.headingOne,
          ),
       const Gap(6),
          Material(
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => tiklayinca(),
                child: Container(
                  padding:const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Icon(iconBolumu),
                    const Gap(6),
                      Text(metinDegeri),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
    );
  }
}
