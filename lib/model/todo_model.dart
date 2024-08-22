
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TodoModel {
  String? docID;
  final String gorevBasligi;
  final String aciklama;
  final String kategori;
  final String tarih;
  final String saat;
  final bool isDone;
  TodoModel({
    this.docID,
    required this.gorevBasligi,
    required this.aciklama,
    required this.kategori,
    required this.tarih,
    required this.saat,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docID': docID,
      'gorevBasligi': gorevBasligi,
      'aciklama': aciklama,
      'kategori': kategori,
      'tarih': tarih,
      'saat': saat,
      'isDone':isDone,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      gorevBasligi: map['gorevBasligi'] as String,
      aciklama: map['aciklama'] as String,
      kategori: map['kategori'] as String,
      tarih: map['tarih'] as String,
      saat: map['saat'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
        docID: doc.id,
        gorevBasligi: doc['gorevBasligi'],
        aciklama: doc['aciklama'],
        kategori: doc['kategori'],
        tarih: doc['tarih'],
        saat: doc['saat'],
        isDone: doc['isDone']);

  }
}