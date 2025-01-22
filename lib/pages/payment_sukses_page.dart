import 'package:flutter/material.dart';
import 'package:pizza_delivery/pages/delivery_page.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PaymentSuccessPageState createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const DeliveryPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                shape: BoxShape.circle, // Tetap berbentuk lingkaran
              ),
              clipBehavior: Clip.hardEdge, // Potong gambar sesuai lingkaran
              child: Image.asset(
                'assets/paymentsuccess.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            // Pesan sukses
            const Text(
              "Payment Successful !!!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Tombol untuk navigasi manual
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DeliveryPage()),
                );
              },
              child: const Text('Go to Delivery Page'),
            ),
          ],
        ),
      ),
    );
  }
}
