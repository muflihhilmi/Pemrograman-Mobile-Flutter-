import 'package:flutter/material.dart';
import 'package:pizza_delivery/pages/virtual_acc_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPayment = 'BCA Virtual Account';
  int _clickCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true, // Title berada di tengah
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Payment",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // Membuat teks bold
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Virtual Account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              // Daftar Virtual Account
              paymentOption(
                logo: 'assets/bca_logo.png',
                title: 'BCA Virtual Account',
              ),
              paymentOption(
                logo: 'assets/mandiri_logo.png',
                title: 'Mandiri Virtual Account',
              ),
              paymentOption(
                logo: 'assets/bni_logo.png',
                title: 'BNI Virtual Account',
              ),
              paymentOption(
                logo: 'assets/bri_logo.png',
                title: 'BRI Virtual Account',
              ),
              paymentOption(
                logo: 'assets/permata_logo.png',
                title: 'Permata Virtual Account',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentOption({required String logo, required String title}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = title;
          _clickCount++;

          // Navigasi ke halaman VirtualAccountPage setelah klik kedua
          if (_clickCount == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VirtualAccountPage(bankName: title),
              ),
            );
            _clickCount = 0; // Reset click count
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300), // Animasi untuk highlight
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selectedPayment == title
              ? Colors.green.withOpacity(0.1)
              : Colors.white,
          border: Border.all(
            color: Colors.grey, // Border abu-abu untuk setiap kotak
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(
              logo,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: selectedPayment == title
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            if (selectedPayment == title)
              const Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
