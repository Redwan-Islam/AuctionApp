import 'package:flutter/material.dart';

class dashScreenCard extends StatelessWidget {
  const dashScreenCard({
    required this.text,
    required this.image,
    required this.onPressed,
  });
  final String text;
  final String image;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
          style: TextButton.styleFrom(
              elevation: 1, backgroundColor: Colors.blueAccent),
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  image,
                  height: 128,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
