import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'profile_page.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  List<Map<String, dynamic>> favorites = [];

  // Fungsi untuk membaca data dari file CSV
  Future<void> _loadFavorites() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/favorite.csv';

    final file = File(path);
    if (await file.exists()) {
      final lines = await file.readAsLines();
      setState(() {
        favorites = lines
            .skip(1) // Lewati header CSV
            .map((line) {
              final parts = line.split(',');
              if (parts.length >= 6) {
                bool isVeg = parts[4].toLowerCase() == 'true';
                return {
                  'title': parts[0],
                  'price': parts[1],
                  'imageURL': parts[2],
                  'description': parts[3],
                  'isVeg': isVeg,
                  'originalPrice': parts[5],
                  'isLiked': true, // Set semua item di halaman ini sebagai disukai
                };
              } else {
                return {
                  'title': 'Unknown',
                  'price': '0.00',
                  'imageURL': 'https://via.placeholder.com/150',
                  'description': 'No description',
                  'isVeg': false,
                  'originalPrice': '0.00',
                  'isLiked': true,
                };
              }
            })
            .toList();
      });
    }
  }

  // Fungsi untuk menghapus item dari daftar favorit dan memperbarui CSV
  Future<void> _removeFavorite(int index) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/favorite.csv';
    final file = File(path);

    if (await file.exists()) {
      final lines = await file.readAsLines();
      final updatedLines = [lines.first] // Keep the header
          ..addAll(lines.skip(1).where((line) {
            final parts = line.split(',');
            return parts[0] != favorites[index]['title']; // Remove pizza based on title
          }));

      await file.writeAsString(updatedLines.join('\n')); // Update CSV file
    }

    setState(() {
      favorites.removeAt(index); // Remove item from the list
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFavorites(); // Memuat data saat halaman pertama kali dimuat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          "Like",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              crossAxisSpacing: 16, // Spacing between cards
              mainAxisSpacing: 16, // Spacing between rows
              childAspectRatio: 0.75, // Adjust for card proportions
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        child: Center(
                          child: Image.network(
                            favorite['imageURL'] != null &&
                                    Uri.parse(favorite['imageURL']).isAbsolute
                                ? favorite['imageURL']
                                : 'https://via.placeholder.com/150',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: favorite['isVeg']
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  favorite['isVeg'] ? "VEG" : "NON-VEG",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "BALANCE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            favorite['title']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            favorite['description'] ?? "No description",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    favorite['price']!,
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    favorite['originalPrice'] ?? "No price",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _removeFavorite(index); // Menghapus item favorit
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // Tambahkan produk ke keranjang (logika keranjang)
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Produk ditambahkan ke keranjang"),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
