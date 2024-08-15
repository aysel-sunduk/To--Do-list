import 'package:flutter_riverpod/flutter_riverpod.dart';

final tarihProvider = StateProvider<String>((ref) {
  return "dd/mm/yy";
});
final saatProvider = StateProvider<String>((ref) {
  return " hh : mm " ;
});