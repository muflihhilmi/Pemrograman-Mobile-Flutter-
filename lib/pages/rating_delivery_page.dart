import 'package:flutter/material.dart';
import 'package:pizza_delivery/pages/discover_page.dart';

class DeliveryRatingPage extends StatefulWidget {
  const DeliveryRatingPage({super.key});

  @override
  State<DeliveryRatingPage> createState() => _DeliveryRatingPageState();
}

class _DeliveryRatingPageState extends State<DeliveryRatingPage> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                centerTitle: true,
                title: const Text(
                  'Delivery',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              const Text(
                'Order arrived!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.access_time, color: Colors.red),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.red,
                    ),
                  ),
                  Icon(Icons.store, color: Colors.red),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.red,
                    ),
                  ),
                  Icon(Icons.person, color: Colors.red),
                  Expanded(
                    child: Divider(thickness: 2, color: Colors.red),
                  ),
                  Icon(Icons.home, color: Colors.red),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            'https://via.placeholder.com/150', // Ganti URL ini dengan foto pengantar
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Gunteng Jovandi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                            Text(
                              ' (5.0)',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Give your response',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return IconButton(
                              icon: Icon(
                                _selectedRating > index
                                    ? Icons.star
                                    : Icons.star_border,
                                color: _selectedRating > index
                                    ? Colors.amber
                                    : Colors.grey,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_selectedRating == index + 1) {
                                    _selectedRating = 0; // Unclick star
                                  } else {
                                    _selectedRating = index + 1; // Set rating
                                  }
                                });
                              },
                            );
                          }),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Send message',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {
                                  // Tambahkan logika kirim pesan di sini
                                },
                              ),
                              contentPadding: const EdgeInsets.all(16.0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DiscoverPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                          ),
                          child: const Text(
                            "Back to Home",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
