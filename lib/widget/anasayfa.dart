import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:yapilacaklarlistesi1/common/modeli_goster.dart';
import 'package:yapilacaklarlistesi1/provider/servis_provider.dart';
import 'gorev_listesi_kart_widget.dart';
import 'package:yapilacaklarlistesi1/widget/takvim_sayfasi.dart';
import 'package:yapilacaklarlistesi1/widget/bildirim_sayfasi.dart';
import 'package:yapilacaklarlistesi1/screens/account_screen.dart'; // AccountScreen'i buraya import edin

class AnaSayfa extends ConsumerWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade200,
            radius: 25,
            child: ClipOval(
              child: Image.asset(
                "assets/profil.jpg",
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
          ),
          title: const Text(
            "Aysel SÜNDÜK",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TakvimSayfasi()),
                    );
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BildirimSayfasi()),
                    );
                  },
                  icon: Stack(
                    children: [
                      const Icon(Icons.notifications),
                      // Eğer todoData.hasValue ve veriler varsa, göstergeyi göster
                      if (todoData.hasValue && (todoData.value ?? []).isNotEmpty)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Ayarlar ikonunu ekliyoruz
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AccountScreen()), // AccountScreen'e yönlendirme
                    );
                  },
                  icon: const Icon(Icons.settings), // Ayarlar ikonu
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Yapılacaklar",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD5E8FA),
                      foregroundColor: Colors.blue.shade500,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      context: context,
                      builder: (context) => const YeniGorevModeliEkle(),
                    ),
                    child: const Text(
                      "+ Yeni Görev",
                    ),
                  ),
                ],
              ),
              const Gap(20),
              todoData.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(child: Text("Görev bulunamadı"));
                  } else {
                    return ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => GorevListesiKartWidget(
                        getIndex: index,
                      ),
                    );
                  }
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text("Bir hata oluştu: $error")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
