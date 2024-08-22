import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:yapilacaklarlistesi1/widget/setting_item.dart';
import 'package:yapilacaklarlistesi1/widget/setting_switch.dart';
import '../widget/help_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = false;
  String selectedLanguage = "Türkçe";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: "Asel");
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Metinleri seçilen dile göre dinamik hale getirmek için bir yöntem
  String getTranslatedText(String text) {
    if (selectedLanguage == 'İngilizce') {
      switch (text) {
        case 'Ayarlar':
          return 'Settings';
        case 'Hesabım':
          return 'My Account';
        case 'Karanlık Mod':
          return 'Dark Mode';
        case 'Dil':
          return 'Language';
        case 'Yardım':
          return 'Help';
        case 'İngilizce':
          return 'English';
        case 'Ad':
          return 'First Name';
        case 'Soyad':
          return 'Last Name';
        case 'E-posta':
          return 'Email';
        case 'Kaydet':
          return 'Save';
        default:
          return text;
      }
    } else {
      return text; // Türkçe için orijinal metni döndürüyoruz
    }
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      // Profil güncelleme işlemleri burada yapılır
      // Örneğin, bir API'ye veya veritabanına kayıt yapabilirsiniz
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(getTranslatedText("Profil bilgileri başarıyla kaydedildi."))),
      );

      // Geri dönmek için Navigator.pop kullanılır
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(); // Geri gitmek için
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        actions: [
          IconButton(
            icon: const Icon(Ionicons.checkmark_outline),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslatedText("Ayarlar"),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                getTranslatedText("Hesabım"),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: getTranslatedText("Ad"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return getTranslatedText("Ad boş olamaz");
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _surnameController,
                      decoration: InputDecoration(
                        labelText: getTranslatedText("Soyad"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return getTranslatedText("Soyad boş olamaz");
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: getTranslatedText("E-posta"),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return getTranslatedText("E-posta boş olamaz");
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return getTranslatedText("Geçersiz e-posta adresi");
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                getTranslatedText("Ayarlar"),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SettingItem(
                baslik: getTranslatedText("Dil"),
                icon: Ionicons.earth,
                bgcolor: Colors.orange.shade100,
                iconColor: Colors.orange,
                value: selectedLanguage,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Dil Seçimi'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text('Türkçe'),
                              onTap: () {
                                setState(() {
                                  selectedLanguage = "Türkçe";
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: const Text('İngilizce'),
                              onTap: () {
                                setState(() {
                                  selectedLanguage = "İngilizce";
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              SettingSwitch(
                baslik: getTranslatedText("Karanlık Mod"),
                icon: Ionicons.moon,
                bgcolor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: isDarkMode,
                onTap: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                baslik: getTranslatedText("Yardım"),
                icon: Ionicons.help_circle,
                bgcolor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
