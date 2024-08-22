import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapilacaklarlistesi1/provider/servis_provider.dart';

import '../model/todo_model.dart';

class GorevListesiKartWidget extends ConsumerWidget {
  const GorevListesiKartWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);

    return todoData.when(
      data: (todoData) {
        Color kategoriRengi = Colors.white;

        final getKategori = todoData[getIndex].kategori;

        switch (getKategori) {
          case 'Eğitim':
            kategoriRengi = Colors.green;
            break;
          case 'İş':
            kategoriRengi = Colors.blue.shade700;
            break;
          case 'Genel':
            kategoriRengi = Colors.amber.shade700;
            break;
        }

        return InkWell(
          onTap: () {
            // Güncelleme formunu açmak için bir metod çağırabilirsiniz
            _showUpdateDialog(context, todoData[getIndex], ref);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: kategoriRengi,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                ref
                                    .read(servisProvider)
                                    .gorevSilme(todoData[getIndex].docID),
                          ),
                          title: Text(
                            todoData[getIndex].gorevBasligi,
                            maxLines: 1,
                            style: TextStyle(
                                decoration: todoData[getIndex].isDone
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          subtitle: Text(
                            todoData[getIndex].aciklama,
                            maxLines: 1,
                            style: TextStyle(
                                decoration: todoData[getIndex].isDone
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: Colors.blue.shade800,
                              shape: const CircleBorder(),
                              value: todoData[getIndex].isDone,
                              onChanged: (value) {
                                // Checkbox durumunu güncelle
                                final updatedTodo = TodoModel(
                                  docID: todoData[getIndex].docID,
                                  gorevBasligi: todoData[getIndex].gorevBasligi,
                                  aciklama: todoData[getIndex].aciklama,
                                  kategori: todoData[getIndex].kategori,
                                  tarih: todoData[getIndex].tarih,
                                  saat: todoData[getIndex].saat,
                                  isDone: value ?? false, // Güncellenmiş değer
                                );

                                ref.read(servisProvider).gorevGuncelleme(
                                    todoData[getIndex].docID, updatedTodo);
                              },
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -12),
                          child: Column(
                            children: [
                              Divider(
                                thickness: 1.5,
                                color: Colors.grey.shade200,
                              ),
                              Row(
                                children: [
                                  Text(todoData[getIndex].tarih),
                                  const Gap(12),
                                  Text(todoData[getIndex].saat),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => Text('Hata: $error'),
      loading: () => const CircularProgressIndicator(),
    );
  }

  void _showUpdateDialog(BuildContext context, TodoModel todo, WidgetRef ref) {
    final baslikController = TextEditingController(text: todo.gorevBasligi);
    final aciklamaController = TextEditingController(text: todo.aciklama);
    final tarihController = TextEditingController(text: todo.tarih);
    final saatController = TextEditingController(text: todo.saat);

    // Seçilen kategori için bir değişken
    String selectedKategori = todo.kategori;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Görev Güncelle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: baslikController,
                decoration: const InputDecoration(labelText: 'Başlık'),
              ),
              TextField(
                controller: aciklamaController,
                decoration: const InputDecoration(labelText: 'Açıklama'),
              ),
              // Radio butonları ekleyin
              Column(
                children: [
                  ListTile(
                    title: const Text('Eğitim'),
                    leading: Radio<String>(
                      value: 'Eğitim',
                      groupValue: selectedKategori,
                      onChanged: (value) {
                        selectedKategori = value!;
                        (context as Element).markNeedsBuild(); // UI'yi güncelle
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('İş'),
                    leading: Radio<String>(
                      value: 'İş',
                      groupValue: selectedKategori,
                      onChanged: (value) {
                        selectedKategori = value!;
                        (context as Element).markNeedsBuild(); // UI'yi güncelle
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Genel'),
                    leading: Radio<String>(
                      value: 'Genel',
                      groupValue: selectedKategori,
                      onChanged: (value) {
                        selectedKategori = value!;
                        (context as Element).markNeedsBuild(); // UI'yi güncelle
                      },
                    ),
                  ),
                ],
              ),
              TextField(
                controller: tarihController,
                decoration: const InputDecoration(labelText: 'Tarih'),
              ),
              TextField(
                controller: saatController,
                decoration: const InputDecoration(labelText: 'Saat'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Güncellemeleri kaydet
                final updatedTodo = TodoModel(
                  docID: todo.docID,
                  gorevBasligi: baslikController.text,
                  aciklama: aciklamaController.text,
                  kategori: selectedKategori,
                  // Güncellenmiş kategori
                  tarih: tarihController.text,
                  saat: saatController.text,
                  isDone: todo.isDone, // Mevcut isDone değerini koru
                );

                ref.read(servisProvider).gorevGuncelleme(
                    todo.docID, updatedTodo);
                Navigator.of(context).pop();
              },
              child: const Text('Kaydet'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
          ],
        );
      },
    );
  }
}
