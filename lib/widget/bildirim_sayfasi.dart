import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:yapilacaklarlistesi1/provider/servis_provider.dart';


class BildirimSayfasi extends ConsumerWidget {
  const BildirimSayfasi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirimler'),
      ),
      body: todoData.when(
        data: (data) {
          final now = DateTime.now();
          final dateFormat = DateFormat('dd-MM-yyyy');

          final todayTasks = data.where((task) {
            try {
              final taskDate = dateFormat.parse(task.tarih);
              return dateFormat.format(taskDate) == dateFormat.format(now);
            } catch (e) {
             // print("Tarih formatı hatası: $e");
              return false;
            }
          }).toList();

          if (todayTasks.isEmpty) {
            return const Center(child: Text("Bugün tamamlanması gereken görev bulunmuyor."));
          } else {
            return ListView.builder(
              itemCount: todayTasks.length,
              itemBuilder: (context, index) {
                final task = todayTasks[index];
                return ListTile(
                  title: Text(task.gorevBasligi),
                  subtitle: Text(task.aciklama),
                );
              },
            );
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text("Bir hata oluştu: $error")),
      ),
    );
  }
}