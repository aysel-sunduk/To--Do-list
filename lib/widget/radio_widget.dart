import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapilacaklarlistesi1/provider/radio_provider.dart';

class RadioWidget extends ConsumerWidget {
  const RadioWidget({
    super.key,
    required this.kategoriRengi,
    required this.radioBtnBaslik,
    required this.girilenDeger,
    required this.onChangeValue,
  });

  final String radioBtnBaslik;
  final Color kategoriRengi;
  final int girilenDeger;
  final VoidCallback onChangeValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radio = ref.watch(radioProvider);

    return Material(
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: kategoriRengi,
        ),
        child: RadioListTile(
          activeColor: kategoriRengi,
          contentPadding: EdgeInsets.zero,
          title: Transform.translate(
              offset: const Offset(-22, 0),
              child: Text(
                radioBtnBaslik,
                style: TextStyle(
                  color: kategoriRengi,
                  fontWeight: FontWeight.w700,
                ),
              )),
          value: girilenDeger,
          groupValue: radio,
          onChanged: (value) => onChangeValue() ,
        ),
      ),
    );
  }
}
