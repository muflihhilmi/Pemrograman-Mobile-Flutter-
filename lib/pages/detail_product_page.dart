import 'package:flutter/material.dart';
import 'package:pizza_delivery/pages/detail_order_page.dart';

class DetailProductPage extends StatefulWidget {
  final String title;
  final String price;
  final String imageURL;
  final String description;
  final bool isVeg;

  const DetailProductPage({
    required this.title,
    required this.price,
    required this.imageURL,
    required this.description,
    required this.isVeg,
    super.key, required Map<String, String> product, required List products,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int stock = 1; // Jumlah stok default
  List<bool> selectedToppings = [
    false,
    false,
    false
  ]; // Menyimpan status topping yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // AppBar Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.black,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Jl. Mawar, Jakarta Barat ...",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Pizza Image and Details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1, // Mengontrol proporsi teks
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          const Text(
                            "Pizza",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Napoletana",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),

                          // Rating
                          Row(
                            children: [
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 19,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                "(5.0)",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Price
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.price,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "Rp60,000",
                                style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Nutrition Information
                          GridView.count(
                            shrinkWrap:
                                true, // Agar grid menyesuaikan tinggi konten
                            crossAxisCount: 2, // Dua kotak per baris
                            crossAxisSpacing:
                                10, // Jarak horizontal antar kotak
                            mainAxisSpacing: 10, // Jarak vertikal antar kotak
                            childAspectRatio:
                                2.2, // Rasio aspek kotak (lebar lebih besar dari tinggi)
                            children: [
                              _buildNutritionInfo(
                                  "267 Calories", Icons.local_fire_department),
                              _buildNutritionInfo("21g Fat", Icons.oil_barrel),
                              _buildNutritionInfo(
                                  "36g Protein", Icons.fitness_center),
                              _buildNutritionInfo(
                                  "38g Carbs", Icons.bakery_dining),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Gambar pizza
                    Expanded(
                      flex: 3, // Mengontrol proporsi gambar pizza
                      child: Align(
                        alignment: const Alignment(
                            1.9, 0.0), // Menggeser gambar ke kanan
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            widget.imageURL,
                            width: 250, // Ukuran gambar yang lebih besar
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Toppings Section (non-bold, more prominent gray)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Toppings:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6F6F6F), // Clear gray color for contrast
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildToppingChip(
                          context, "Truffle Temptation Extravaganza", 0),
                      _buildToppingChip(context, "Prosciutto/cured ham", 1),
                      _buildToppingChip(context, "Rocket/Arugula", 2),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Promo Section (non-bold, more prominent gray)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Promo",
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            Color(0xFF6F6F6F), // Clear gray color for contrast
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ],
                ),

                const SizedBox(height: 10),

                const Spacer(),

                // Footer Section with centered text
                Transform.translate(
                  offset: Offset(
                      0, -16), // Geser kedua kalimat ke atas sebanyak 10 piksel
                  child: const Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          "Creating joy: your pizza, your",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF6F6F6F),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "rules, best taste!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF6F6F6F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Spacer(),

                // Quantity and Buttons Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _buildQuantityButton(Icons.remove, () {
                          setState(() {
                            if (stock > 1) stock--;
                          });
                        }),
                        const SizedBox(width: 10),
                        Text(
                          "$stock",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 10),
                        _buildQuantityButton(Icons.add, () {
                          setState(() {
                            stock++;
                          });
                        }),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: const Text("Add to cart",
                          style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailPage(products: []),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetailPage(products: []),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text("Buy Now",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for Nutrition Info
  Widget _buildNutritionInfo(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6), // Margin lebih kecil
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8), // Sudut lebih kecil
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.red, size: 20), // Ukuran ikon lebih kecil
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black54), // Ukuran teks lebih kecil
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // Widget for Topping Chip
  Widget _buildToppingChip(BuildContext context, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedToppings[index] = !selectedToppings[index]; // Toggle status
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: selectedToppings[index] ? Colors.pink : Colors.red.shade900,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  // Widget for Quantity Button
  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}
