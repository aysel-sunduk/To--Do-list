import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yardım'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            Text(
              'Genel Bilgiler',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Bu uygulama, günlük görevlerinizi düzenlemenize ve takip etmenize yardımcı olur. Görevlerinizi ekleyin, düzenleyin ve tamamlayın.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Görev Ekleme',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Yeni bir görev eklemek için ana ekranda "Görev Ekle" butonuna tıklayın. Başlık, açıklama, tarih ve saat bilgilerini girin ve "Kaydet" butonuna basın.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Görev Düzenleme ve Silme',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Bir görevi düzenlemek için, görevin üzerine tıklayın ve düzenlemek istediğiniz bilgileri değiştirin. "Kaydet" butonuna tıklayarak güncellemelerinizi kaydedin.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Bir görevi silmek için, görevin üzerindeki "Sil" ikonunu seçin.',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 20),
            Text(
              'Tema ve Ayarlar',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Karanlık veya açık tema arasında geçiş yapmak için uygulama ayarlarına gidin ve "Tema" seçeneğinden tercih ettiğiniz temayı seçin.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Uygulamanın dilini değiştirmek için ayarlardan "Dil" seçeneğini kullanın.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Sorun Giderme ve İletişim',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Text(
              'Daha fazla yardım veya önerileriniz için lütfen sundukaysel@gmail.com ile iletişime geçin.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
