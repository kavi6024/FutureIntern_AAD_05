import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode_scanner/screens/post_scan.dart';

enum CornerLocation {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  late QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  bool isQR = false;
  bool isLink = false;
  String text = "";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderRadius: 15,
                borderColor: isQR ? Colors.green : Colors.red,
                borderLength: 35,
                borderWidth: 10,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40.0),
            alignment: Alignment.topLeft,
            child: SizedBox(
              child: IconButton(
                icon: const Icon(Icons.close),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Center(
              child: AnimatedSize(
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 500),
                child: SizedBox(
                  width: isQR ? 80.0 : 0.0,
                  height: isQR ? 80.0 : 0.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostScan(
                            text: text,
                            isLink: isLink,
                          ),
                        ),
                      );
                    },
                    child: isQR
                        ? (!isLink
                            ? const Icon(Icons.text_fields_rounded, size: 27.5)
                            : const Icon(Icons.link, size: 30))
                        : const SizedBox(),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFF2D2E30),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 15,
                    child: const Divider(
                      color: Colors.white,
                      thickness: 1.5,
                    ),
                  ),
                  const Text(
                    "Make sure to align the QR Code inside the frame",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isValidURL(String url) {
    final urlPattern = RegExp(
      r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
      caseSensitive: false,
    );
    return urlPattern.hasMatch(url);
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    Timer? qrPresenceTimer;
    _controller.scannedDataStream.listen(
      (scanData) async {
        // _controller.pauseCamera(); // Pause camera on scan
        setState(() {
          text = scanData.code ?? "";
          isLink = isValidURL(text);
          isQR = true;
          if (qrPresenceTimer != null) {
            qrPresenceTimer!.cancel();
          }
          qrPresenceTimer = Timer(const Duration(milliseconds: 500), () {
            if (mounted) {
              setState(() {
                isQR = false;
              }); 
            }
          });
        });
        // _controller.resumeCamera(); // Resume camera after processing
      },
    );
  }
}
