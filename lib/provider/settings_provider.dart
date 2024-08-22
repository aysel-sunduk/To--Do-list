import 'package:flutter_riverpod/flutter_riverpod.dart';

class Settings {
  String name;
  String surname;
  String email;
  bool isDarkMode;
  String language;

  Settings({
    required this.name,
    required this.surname,
    required this.email,
    this.isDarkMode = false,
    this.language = 'Türkçe',
  });

  Settings copyWith({
    String? name,
    String? surname,
    String? email,
    bool? isDarkMode,
    String? language,
  }) {
    return Settings(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
    );
  }
}

final settingsProvider = StateProvider<Settings>((ref) => Settings(
  name: 'Zeynep',
  surname: 'Sündük',
  email: 'sundukzeynep@gmail.com',
));
