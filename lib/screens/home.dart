import 'package:flutter/material.dart';
import 'package:qrcode_scanner/screens/scanner.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Scan QR Code",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Proceed by clicking the QR Icon",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 3),
              Text(
                "and placing the QR Code within",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 3),
              Text(
                "the frame",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 100),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scanner(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange[300],
                  ),
                  child: const Icon(Icons.qr_code_scanner_sharp, size: 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
