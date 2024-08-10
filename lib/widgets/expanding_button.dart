import 'package:flutter/material.dart';

class ExpandingActionButton extends StatefulWidget {
  const ExpandingActionButton({super.key});

  @override
  State<ExpandingActionButton> createState() => _ExpandingActionButtonState();
}

class _ExpandingActionButtonState extends State<ExpandingActionButton>
    with SingleTickerProviderStateMixin {
  bool isQR = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Simulate QR detection toggle for demonstration
        setState(() {
          isQR = !isQR;
        });
      },
      child: AnimatedSize(
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 500),
        child: Container(
          width: isQR ? 200.0 : 0.0, // Width expands from 0 to 200
          height: isQR ? 60.0 : 0.0, // Height expands from 0 to 60
          child: ElevatedButton(
            onPressed: isQR
                ? () {
                    print("Button Pressed");
                  }
                : null,
            child: isQR ? Text('Proceed') : SizedBox(),
          ),
        ),
      ),
    );
  }
}
