import 'package:flutter/material.dart';

class SavedAddressPage extends StatelessWidget {
  const SavedAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Memastikan background meluas hingga ke belakang AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Membuat AppBar transparan
        elevation: 0, // Menghapus bayangan AppBar
        title: const Text(
          'Saved Address',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Membuat teks bold
            fontSize: 20, // Menyesuaikan ukuran font jika diperlukan
          ),
          textAlign: TextAlign.center, // Menempatkan teks di tengah
        ),
        centerTitle: true, // Memastikan judul ada di tengah
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white, // Warna putih di atas
              Color(0xFFBDBDBD), // Warna abu-abu lebih gelap di bawah
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).padding.top +
                      kToolbarHeight), // Memberikan ruang di bawah AppBar
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4, // Memberikan efek shadow
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(
                          0xFFFFCDD2), // Warna merah muda sedikit lebih gelap
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.red),
                  ),
                  title: const Text(
                    'Add New Address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Membuat teks bold
                    ),
                  ),
                  subtitle: const Text(
                    'Save your favorite delivery location',
                    style: TextStyle(
                      fontSize: 12, // Ukuran font lebih kecil
                      color: Colors.grey, // Warna abu-abu
                    ),
                  ),
                  onTap: () {
                    // Tambahkan logika untuk menambahkan alamat baru
                  },
                ),
              ),
              const SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4, // Memberikan efek shadow
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(
                          0xFFFFCDD2), // Warna merah muda sedikit lebih gelap
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.bookmark_border, color: Colors.red),
                  ),
                  title: const Text(
                    'Leonardy Lie',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Membuat teks bold
                    ),
                  ),
                  onTap: () {
                    // Tambahkan logika untuk melihat atau mengedit alamat
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
