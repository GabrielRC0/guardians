import 'package:flutter/material.dart';

class GuardiansBox extends StatelessWidget {
  final String title;
  final ImageProvider image;
  final String text; // Add this line

  const GuardiansBox({
    Key? key,
    required this.title,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 180,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/inside.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            height: 65,
            width: 275,
            right: 5,
            top: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            left: -25,
            bottom: -40,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
