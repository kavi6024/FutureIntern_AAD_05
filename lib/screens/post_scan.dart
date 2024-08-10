import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostScan extends StatefulWidget {
  final String text;
  final bool isLink;
  const PostScan({
    super.key,
    required this.text,
    required this.isLink,
  });

  @override
  State<PostScan> createState() => _PostScanState();
}

class _PostScanState extends State<PostScan> {
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "QR ${widget.isLink ? "Link" : "Text"}",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: widget.text)).then(
                    (value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Center(
                          child: Text('Copied to clipboard'),
                        ),
                      ));
                    },
                  );
                },
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          widget.text,
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Click to copy to clipboard",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              widget.isLink
                  ? ElevatedButton(
                      onPressed: () {
                        _launchUrl(widget.text);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            Colors.orange.shade300),
                      ),
                      child: const Text(
                        "Go To Link",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
