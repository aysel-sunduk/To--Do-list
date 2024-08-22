import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yapilacaklarlistesi1/model/todo_model.dart';

class TodoServis {
  final todoKoleksiyon = FirebaseFirestore.instance.collection('todoApp');

  void yeniGorevEkle(TodoModel model) {
    todoKoleksiyon.add(model.toMap());
  }

  void gorevGuncelleme(String? docID, TodoModel updatedModel) {
    if (docID != null) {
      todoKoleksiyon.doc(docID).update(updatedModel.toMap());
    } else {
      print('Document ID is null.');
    }
  }




  void gorevSilme(String? docID) {
    todoKoleksiyon.doc(docID).delete();
  }
}