import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:yapilacaklarlistesi1/model/todo_model.dart';
import 'package:yapilacaklarlistesi1/provider/radio_provider.dart';
import 'package:yapilacaklarlistesi1/provider/servis_provider.dart';
import 'package:yapilacaklarlistesi1/provider/tarih_saat_provider.dart';
import 'package:yapilacaklarlistesi1/sabitler/app_style.dart';
import 'package:yapilacaklarlistesi1/widget/metinAlani_widget.dart';
import 'package:yapilacaklarlistesi1/widget/radio_widget.dart';
import 'package:yapilacaklarlistesi1/widget/tarih_saat_widget.dart';
class YeniGorevModeliEkle extends ConsumerStatefulWidget {
  YeniGorevModeliEkle({super.key});

  @override
  ConsumerState<YeniGorevModeliEkle> createState() => _YeniGorevModeliEkleState();
}

class _YeniGorevModeliEkleState extends ConsumerState<YeniGorevModeliEkle> {
  final baslikDenetleyici = TextEditingController();
  final aciklamaDenetleyici = TextEditingController();

  @override
  void dispose() {
    baslikDenetleyici.dispose();
    aciklamaDenetleyici.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tarihProv = ref.watch(tarihProvider);
   return SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text(
            "Yapılacak Yeni Görev",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        Divider(
          thickness: 1.2,
          color: Colors.grey.shade200,
        ),
        const Gap(12),
        const Text(
          "Görev Başlığı",
          style: AppStyle.headingOne,
        ),
        const Gap(6),
        MetinAlani(
          ipucuMetin: "Görev Adı Ekle",
          maxLine: 1,
          metinDenetleyici: baslikDenetleyici,
        ),
        const Gap(12),
        const Text("Açıklama", style: AppStyle.headingOne),
        const Gap(6),
        MetinAlani(
          ipucuMetin: "Açıklama Ekle",
          maxLine: 5,
          metinDenetleyici: aciklamaDenetleyici,
        ),
        const Gap(12),
        const Text(
          "Kategori",
          style: AppStyle.headingOne,
        ),
        Row(
          children: [
            Expanded(
              child: RadioWidget(
                kategoriRengi: Colors.green,
                radioBtnBaslik: "Eğitim",
                girilenDeger: 1,
                onChangeValue: () =>
                    ref.read(radioProvider.notifier).update((state) => 1),
              ),
            ),

            Expanded(
              child: RadioWidget(
                kategoriRengi: Colors.blue,
                radioBtnBaslik: "İş",
                girilenDeger: 2,
                onChangeValue: () =>
                    ref.read(radioProvider.notifier).update((state) => 2),
              ),
            ),
            Expanded(
              child: RadioWidget(
                kategoriRengi: Colors.amberAccent,
                radioBtnBaslik: "Genel",
                girilenDeger: 3,
                onChangeValue: () =>
                    ref.read(radioProvider.notifier).update((state) => 3),
              ),
            ),
          ],
        ),
        // Tarih ve saat bölümü
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TarihSaatWidget(
                metinBasligi: "Tarih",
                metinDegeri: tarihProv,
                iconBolumu: Icons.calendar_today,
                tiklayinca: () async {
                  final getValue = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2050));

                  if (getValue != null) {
                    final format = DateFormat.yMd();
                    ref
                        .read(tarihProvider.notifier)
                        .update((state) => format.format(getValue));
                  }
                },
              ),
            ),
            const Gap(22),
            Expanded(
              child: TarihSaatWidget(
                metinBasligi: "Saat",
                metinDegeri: ref.watch(saatProvider),
                iconBolumu: Icons.access_time,
                tiklayinca: () async {
                  final getTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (getTime != null) {
                    ref
                        .read(saatProvider.notifier)
                        .update((state) => getTime.format(context));
                  }
                },
              ),
            ),
          ],
        ),
        // Buton bölümü
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade800,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: BorderSide(
                    color: Colors.blue.shade800,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("İptal Et"),
              ),
            ),
            const Gap(20),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  final getRadioDegeri = ref.read(radioProvider);
                  String kategori = '';

                  switch (getRadioDegeri) {
                    case 1:
                      kategori = 'Eğitim';
                      break;
                    case 2:
                      kategori = 'İş';
                      break;
                    case 3:
                      kategori = 'Genel';
                      break;
                  }

                  ref.read(servisProvider).yeniGorevEkle(TodoModel(
                    gorevBasligi: baslikDenetleyici.text,
                    aciklama: aciklamaDenetleyici.text,
                    kategori: kategori,
                    tarih: ref.read(tarihProvider),
                    saat: ref.read(saatProvider),
                    isDone: false,
                  ));

                  baslikDenetleyici.clear();
                  aciklamaDenetleyici.clear();
                  ref.read(radioProvider.notifier).update((state) => 0);
                  Navigator.pop(context);
                },
                child: const Text("Oluştur"),
              ),
            ),
          ],
        )
      ],
    ),
  ),
);

  }
}
