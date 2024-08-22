import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapilacaklarlistesi1/provider/servis_provider.dart';
import 'package:intl/intl.dart';


class TakvimSayfasi extends ConsumerWidget {
  const TakvimSayfasi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Takvim'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 01, 01),
            lastDay: DateTime.utc(2050, 12, 31),
            focusedDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            eventLoader: (day) {
              return todoData.maybeWhen(
                data: (data) {
                  final dayString = DateFormat('dd-MM-yyyy').format(day);
                  final events = data.where((task) {
                    try {

                      final taskDate = DateFormat('dd-MM-yyyy').parse(task.tarih);
                      return DateFormat('dd-MM-yyyy').format(taskDate) == dayString;
                    } catch (e) {
                      debugPrint("Tarih format hatası: $e");
                      return false;
                    }
                  }).toList();
                  return events;
                },
                orElse: () => [],
              );
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            onDaySelected: (selectedDay, focusedDay) {
              showDialog(
                context: context,
                builder: (context) {
                  final selectedDayString = DateFormat('dd-MM-yyyy').format(selectedDay);
                  final tasksForDay = todoData.maybeWhen(
                    data: (data) {
                      return data.where((task) {
                        try {
                          final taskDate = DateFormat('dd-MM-yyyy').parse(task.tarih);
                          return DateFormat('dd-MM-yyyy').format(taskDate) == selectedDayString;
                        } catch (e) {
                          debugPrint("Tarih format hatası: $e");
                          return false;
                        }
                      }).toList();
                    },
                    orElse: () => [],
                  );

                  return AlertDialog(
                    title: Text("$selectedDayString Tarihindeki Görevler"),
                    content: tasksForDay.isEmpty
                        ? const Text("Bu tarihte görev bulunmuyor.")
                        : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: tasksForDay.map((task) {
                        return ListTile(
                          title: Text(task.gorevBasligi),
                          subtitle: Text(task.aciklama),
                        );
                      }).toList(),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Kapat"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Expanded(
            child: todoData.when(
              data: (data) {
                final todayString = DateFormat('dd-MM-yyyy').format(DateTime.now());
                final todayTasks = data.where((task) {
                  try {
                    final taskDate = DateFormat('dd-MM-yyyy').parse(task.tarih);
                    return DateFormat('dd-MM-yyyy').format(taskDate) == todayString;
                  } catch (e) {
                    debugPrint("Tarih format hatası: $e");
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
          ),
        ],
      ),
    );
  }
}
