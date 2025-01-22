import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pizza_delivery/pages/detail_order_page.dart';
import 'package:pizza_delivery/pages/discover_page.dart';
import 'package:path_provider/path_provider.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<Map<String, String>> cartItems = [];

  // Fungsi untuk membaca data dari file cart.csv
  Future<void> _loadCartItems() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/cart.csv';
    final file = File(path);

    if (await file.exists()) {
      List<String> lines = await file.readAsLines();

      // Parsing data dari CSV (skip header)
      List<Map<String, String>> items = [];
      for (var i = 1; i < lines.length; i++) {
        List<String> fields = lines[i].split(',');
        items.add({
          'title': fields[0],
          'price': fields[1],
          'imageURL': fields[2],  // The URL for the image
          'description': fields[3],
          'isVeg': fields[4],
          'originalPrice': fields[5],
          'isChecked': 'false',  // Initially set to false
        });
      }
      setState(() {
        cartItems = items;
      });
    }
  }

  // Fungsi untuk menyimpan perubahan ke dalam cart.csv
  Future<void> _saveCartItems() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/cart.csv';
    final file = File(path);

    String content = "Title,Price,ImageURL,Description,isVeg,OriginalPrice,isChecked\n";
    for (var item in cartItems) {
      content += '${item['title']},${item['price']},${item['imageURL']},${item['description']},${item['isVeg']},${item['originalPrice']},${item['isChecked']}\n';
    }
    await file.writeAsString(content);
  }

  @override
  void initState() {
    super.initState();
    _loadCartItems();  // Load cart items when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF7F7F7),
              Color(0xFFE0E0E0),
            ],
          ),
        ),
        child: Column(
          children: [
            AppBar(
              title: const Text(
                'My Chart',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DiscoverPage()),
                  );
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    // Konfirmasi sebelum menghapus item yang dicentang
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Konfirmasi Penghapusan'),
                          content: const Text('Apakah Anda yakin ingin menghapus item yang tercentang?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Membatalkan
                              },
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Hapus item yang dicentang
                                setState(() {
                                  cartItems.removeWhere((item) => item['isChecked'] == 'true');
                                });
                                _saveCartItems();  // Save changes to cart.csv
                                Navigator.pop(context); // Menutup dialog setelah menghapus
                              },
                              child: const Text('Hapus'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete_outline, color: Colors.black),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  var item = cartItems[index];
                  return ChartItem(
                    image: item['imageURL'] ?? 'https://example.com/default_image.png', // Use the URL for the image
                    name: item['title'] ?? 'Unknown Pizza',
                    description: item['description'] ?? 'No description',
                    price: item['price'] ?? 'Unknown price',
                    oldPrice: item['originalPrice'] ?? 'Unknown old price',
                    isChecked: item['isChecked'] == 'true',
                    onCheckedChanged: (value) {
                      setState(() {
                        item['isChecked'] = value ? 'true' : 'false';
                      });
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderDetailPage(products: [])),
                  );
                },
                child: const Text(
                  'Buy Now',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartItem extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final String price;
  final String oldPrice;
  final bool isChecked;
  final ValueChanged<bool> onCheckedChanged;

  const ChartItem({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.isChecked,
    required this.onCheckedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: isChecked ? Colors.grey.shade200 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
              child: Image.network(
                image,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              price,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              oldPrice,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.remove_circle_outline,
                                  color: Colors.grey),
                            ),
                            const Text('1', style: TextStyle(fontSize: 14)),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add_circle_outline,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                onCheckedChanged(!isChecked);
              },
              child: Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(top: 8.0, right: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  color: isChecked ? Colors.grey.shade200 : Colors.white,
                ),
                child: isChecked
                    ? const Icon(Icons.check, color: Colors.red, size: 16)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
