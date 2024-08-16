import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yapilacaklarlistesi1/provider/servis_provider.dart';

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
        return Container(
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
                          onPressed: () => ref
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
                            onChanged: (value) => ref
                                .read(servisProvider)
                                .gorevGuncelleme(
                                    todoData[getIndex].docID, value),
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
        );
      },

       error: (error, stackTrace) => Text('Hata: $error'),
      loading:  () => const CircularProgressIndicator(),
    );
  }
}
