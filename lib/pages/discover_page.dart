import 'package:flutter/material.dart';
import 'dart:io'; 
import 'package:path_provider/path_provider.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pizza_delivery/pages/auth_page.dart';
import 'package:pizza_delivery/pages/chart_page.dart' as chart;
import 'package:pizza_delivery/pages/detail_product_page.dart';
import 'package:pizza_delivery/pages/profile_page.dart';

class DiscoverPage extends StatelessWidget {
  DiscoverPage({super.key});

  // Notifier untuk jumlah item di keranjang
  final ValueNotifier<int> cartItemCount = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AuthPage()),
            );
          },
        ),
        title: Row(
          children: [
            Image.network('https://xzhwnttqotcnycohoznl.supabase.co/storage/v1/object/sign/admin_bitebox/8.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJhZG1pbl9iaXRlYm94LzgucG5nIiwiaWF0IjoxNzM3MjcyMDc2LCJleHAiOjE3Njg4MDgwNzZ9.rIe5OQLUaoo_FZAmd7mjwXTNI4rfMBnIYL-zYoMeo7s&t=2025-01-19T07%3A34%3A36.400Z', height: 40), // Ikon pizza
            const SizedBox(width: 10),
            const Text(
              "PIZZA",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          // Ikon keranjang dengan badge
          ValueListenableBuilder<int>( 
            valueListenable: cartItemCount,
            builder: (context, count, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const chart.ChartPage()),
                      );
                    },
                  ),
                  if (count > 0) // Hanya tampilkan jika ada item di keranjang
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 7, // Jumlah item dalam katalog
          itemBuilder: (context, index) {
            // Data produk
            final products = [
              {
                'title': 'Pizza Napoletana',
                'price': 'Rp53.636',
                'imageURL': 'https://xzhwnttqotcnycohoznl.supabase.co/storage/v1/object/sign/admin_bitebox/Pizza%20Napoletana.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJhZG1pbl9iaXRlYm94L1BpenphIE5hcG9sZXRhbmEucG5nIiwiaWF0IjoxNzM3MDExOTg5LCJleHAiOjE3Njg1NDc5ODl9.ptRoIDyAiMfsR_vWC1gbttlx8pIIJT0HuAWOPeSVBns&t=2025-01-16T07%3A19%3A47.231Z',
                'description':
                    'Creating joy: your pizza your rules best taste!',
                'isVeg': true,
                'originalPrice': 'Rp60.000',
              },
              {
                'title': 'Margheritta',
                'price': 'Rp128.000',
                'imageURL': 'https://xzhwnttqotcnycohoznl.supabase.co/storage/v1/object/sign/admin_bitebox/Margheritta.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJhZG1pbl9iaXRlYm94L01hcmdoZXJpdHRhLnBuZyIsImlhdCI6MTczNzAxMjAyNCwiZXhwIjoxNzY4NTQ4MDI0fQ.MWwLHBePUfEKsRTn90LMc4pRykS2yiL392QNrOhR2Q0&t=2025-01-16T07%3A20%3A22.931Z',
                'description':
                    'Creating joy: your pizza your rules best taste!',
                'isVeg': false,
                'originalPrice': 'Rp135.000',
              },
              {
                'title': 'Spicy Beef Ricota',
                'price': 'Rp128.182',
                'imageURL': 'https://xzhwnttqotcnycohoznl.supabase.co/storage/v1/object/sign/admin_bitebox/Spicy%20Beef%20Ricotta.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJhZG1pbl9iaXRlYm94L1NwaWN5IEJlZWYgUmljb3R0YS5wbmciLCJpYXQiOjE3MzcwMTYxMjEsImV4cCI6MTc2ODU1MjEyMX0.1krIIYmlGWxiZ_u7qCxiXpKyNLkF_OknStkME-WpR54&t=2025-01-16T08%3A28%3A39.360Z',
                'description':
                    'Creating joy: your pizza your rules best taste!',
                'isVeg': true,
                'originalPrice': 'Rp130.500',
              },
              {
                'title': 'American Favourite',
                'price': 'Rp46.364',
                'imageURL': 'https://xzhwnttqotcnycohoznl.supabase.co/storage/v1/object/sign/admin_bitebox/Americana.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJhZG1pbl9iaXRlYm94L0FtZXJpY2FuYS5wbmciLCJpYXQiOjE3MzcwMTYyNjUsImV4cCI6MTc2ODU1MjI2NX0.Jm1jKTVWhrDKkmhzVl8FCDmZYA2oLss_1YfwZq54354&t=2025-01-16T08%3A31%3A03.434Z',
                'description':
                    'Creating joy: your pizza your rules best taste!',
                'isVeg': false,
                'originalPrice': 'Rp50.500',
              },
              {
                'title': 'Cheesy Pizza',
                'price': 'Rp44.000',
                'imageURL': 'https://xzhwnttqotcnycohoznl.supabase.co/storage/v1/object/sign/admin_bitebox/Cheesy%20Pizza.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJhZG1pbl9iaXRlYm94L0NoZWVzeSBQaXp6YS5wbmciLCJpYXQiOjE3MzcwMTYxNTEsImV4cCI6MTc2ODU1MjE1MX0.8-32EU4sAm5AN0wiNM_1oi1WOzF29a0kNkSqUfWcJnE&t=2025-01-16T08%3A29%3A09.541Z',
                'description':
                    'Creating joy: your pizza your rules best taste!',
                'isVeg': true,
                'originalPrice': 'Rp50.000',
              },
              {
                'title': 'Cheesy Sausage',
                'price': 'Rp40.000',
                'imageURL': 'https://xzhwnttqotcnycohoznl.supabase.co/storage/v1/object/sign/admin_bitebox/4.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJhZG1pbl9iaXRlYm94LzQucG5nIiwiaWF0IjoxNzM3MDE2MjE3LCJleHAiOjE3Njg1NTIyMTd9.B3JpAvLAi5HZTUx6WhLpRRPh_lq6X8cwbpsmtLf6EpI&t=2025-01-16T08%3A30%3A15.312Z',
                'description':
                    'Creating joy: your pizza your rules best taste!',
                'isVeg': false,
                'originalPrice': 'Rp45.000',
              },
              {
                'title': 'Spicy Mushroom',
                'price': 'Rp50.182',
                'imageURL': 'https://xzhwnttqotcnycohoznl.supabase.co/storage/v1/object/sign/admin_bitebox/Mushroom%20Pizza.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJhZG1pbl9iaXRlYm94L011c2hyb29tIFBpenphLmpwZyIsImlhdCI6MTczNzAxMjExOCwiZXhwIjoxNzY4NTQ4MTE4fQ.u3wTzB-MxCXzj2MpkwySQLbWt7OXm8IPCC7E65DL-1A&t=2025-01-16T07%3A21%3A56.314Z',
                'description':
                    'Creating joy: your pizza your rules best taste!',
                'isVeg': false,
                'originalPrice': 'Rp80.500',
              },
            ];

            final product = products[index];

            return ProductCard(
              title: product['title'] as String,
              price: product['price'] as String,
              imageURL: product['imageURL'] as String,
              description: product['description'] as String,
              isVeg: product['isVeg'] as bool,
              originalPrice: product['originalPrice'] as String,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailProductPage(
                      title: product['title'] as String,
                      price: product['price'] as String,
                      imageURL: product['imageURL'] as String,
                      description: product['description'] as String,
                      isVeg: product['isVeg'] as bool, product: <String, String>{}, products: [],
                    ),
                  ),
                );
              },
              onAddToCart: () {
                cartItemCount.value++; // Tambahkan jumlah item di keranjang
              },
            );
          },
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}


class ProductCard extends StatefulWidget {
  final String title;
  final String price;
  final String imageURL;
  final String description;
  final bool isVeg;
  final String originalPrice;
  final VoidCallback onTap;
  final VoidCallback onAddToCart; // Callback untuk menambah ke keranjang

  const ProductCard({
    required this.title,
    required this.price,
    required this.imageURL,
    required this.description,
    required this.isVeg,
    required this.originalPrice,
    required this.onTap,
    required this.onAddToCart,
    super.key,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  // Fungsi untuk menyimpan data ke file CSV untuk favorites
  Future<void> _saveToFavorites(String title, String price, String imageURL, String description, bool isVeg, String originalPrice) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/favorite.csv';

    final file = File(path);

    // Tambahkan data ke file CSV
    if (await file.exists()) {
      await file.writeAsString('$title,$price,$imageURL,$description,$isVeg,$originalPrice\n', mode: FileMode.append);
    } else {
      await file.writeAsString('Title,Price,imageURL,Description,isVeg,originalPrice\n$title,$price,$imageURL,$description,$isVeg,$originalPrice\n');
    }

    // Sinkronisasi dengan Supabase
    await _syncWithSupabase(title, price, imageURL, description, isVeg, originalPrice);
  }

  // Fungsi untuk menyimpan data ke file CSV untuk cart
  Future<void> _saveToCart(String title, String price, String imageURL, String description, bool isVeg, String originalPrice) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/cart.csv';

    final file = File(path);

    // Tambahkan data ke file CSV
    if (await file.exists()) {
      await file.writeAsString('$title,$price,$imageURL,$description,$isVeg,$originalPrice\n', mode: FileMode.append);
    } else {
      await file.writeAsString('Title,Price,imageURL,Description,isVeg,originalPrice\n$title,$price,$imageURL,$description,$isVeg,$originalPrice\n');
    }

    // Sinkronisasi dengan Supabase
    await _syncWithSupabaseCart(title, price, imageURL, description, isVeg, originalPrice);
  }

  // Fungsi untuk sinkronisasi dengan Supabase untuk favorites
  Future<void> _syncWithSupabase(String title, String price, String imageURL, String description, bool isVeg, String originalPrice) async {
    final supabase = Supabase.instance.client;

    try {
      await supabase.from('favorite').insert({
        'title': title,
        'price': price,
        'imageURL' : imageURL, 
        'description': description,
        'isVeg': isVeg,
        'originalPrice': originalPrice
      });
    } catch (e) {
      print('Error syncing with Supabase: $e');
    }
  }

  // Fungsi untuk sinkronisasi dengan Supabase untuk cart
  Future<void> _syncWithSupabaseCart(String title, String price, String imageURL, String description, bool isVeg, String originalPrice) async {
    final supabase = Supabase.instance.client;

    try {
      await supabase.from('cart').insert({
        'title': title,
        'price': price,
        'imageURL': imageURL,
        'description': description,
        'isVeg': isVeg,
        'originalPrice': originalPrice
      });
    } catch (e) {
      print('Error syncing with Supabase cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                widget.imageURL, // Gunakan Image.network untuk URL gambar
                fit: BoxFit.contain,
                height: 150,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label VEG / NON-VEG
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: widget.isVeg ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.isVeg ? "VEG" : "NON-VEG",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Label Balance
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "BALANCE",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Nama produk dan deskripsi
                  Text(
                    widget.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  // Harga dan tombol aksi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.price,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.originalPrice,
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
                          // Tombol Love (Favorite)
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                              if (isFavorite) {
                                await _saveToFavorites(widget.title, widget.price, widget.imageURL, widget.description, widget.isVeg, widget.originalPrice);
                              }
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.black,
                            ),
                          ),
                          // Tombol untuk menambah ke keranjang
                          IconButton(
                            onPressed: () async {
                              await _saveToCart(widget.title, widget.price, widget.imageURL, widget.description, widget.isVeg, widget.originalPrice);
                              widget.onAddToCart();
                                                        },
                            icon: const Icon(Icons.add_circle_outline),
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
      ),
    );
  }
}
