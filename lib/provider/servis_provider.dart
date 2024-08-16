import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapilacaklarlistesi1/model/todo_model.dart';
import 'package:yapilacaklarlistesi1/servisler/todo_servis.dart';

final servisProvider = StateProvider<TodoServis>((ref) {
  return TodoServis();
});

final fetchStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('todoApp')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => TodoModel.fromSnapshot(snapshot))
          .toList());
  yield* getData;
});
