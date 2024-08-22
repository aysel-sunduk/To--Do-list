import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

import '../widget/edit_item.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  File? _selectedImage;

  // ImagePicker ile resim seçme işlemi
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                // Kaydetme işlemi burada yapılacak
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: const Size(60, 50),
                elevation: 3,
              ),
              icon: const Icon(
                Ionicons.checkmark,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hesabım",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              // Profil fotoğrafı ve "Resim Yükle" yazısı
              EditItem(
                baslik: "Profil Fotoğrafı",
                widget: Column(
                  children: [
                    _selectedImage != null
                        ? Image.file(
                      _selectedImage!,
                      width: 70,
                      height: 70,
                    )
                        : Image.asset(
                      "assets/profil.jpg",
                      width: 70,
                      height: 70,
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: _pickImage, // Resim yükleme işlemi
                      child: const Text(
                        "Resim Yükle",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const EditItem(
                baslik: "Ad-Soyad: ",
                widget: TextField(),
              ),
              const SizedBox(height: 40),
              const EditItem(
                baslik: "Email: ",
                widget: TextField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
