import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapilacaklarlistesi1/provider/servis_provider.dart';
import '../widget/gorev_listesi_kart_widget.dart'; 

import '../common/modeli_goster.dart';



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
                fit: BoxFit.cover, // Bu satırı ekleyin
                width: 50, // Genişliği ve yüksekliği yarıçapa göre ayarlayın
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
            padding:const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon:const Icon(Icons.calendar_month)),
                IconButton(onPressed: () {}, icon:const Icon(Icons.notifications)),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.symmetric(horizontal: 30),
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
                        "Bugünkü görevler",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Çarşamba,7 Ağustos",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:const Color(0xFFD5E8FA),
                          foregroundColor: Colors.blue.shade500,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                      onPressed: () => showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            context: context,
                            builder: (context) => YeniGorevModeliEkle(),
                          ),
                      child:const Text(
                        "+ Yeni Görev",
                      )),
                ],
              ),

              const Gap(20),
        if (todoData.value == null) 
           const Center(child: CircularProgressIndicator())
        else
              //görev listesi kartları
              ListView.builder(
                itemCount: todoData.value!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => GorevListesiKartWidget(
                  getIndex: index,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
