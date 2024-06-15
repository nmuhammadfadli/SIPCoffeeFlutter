import 'package:flutter/material.dart';

class CardsWidget extends StatelessWidget {
  final ImageProvider<Object> image;
  final String text;
  final VoidCallback onPressed;

  const CardsWidget({
    Key? key,
    required this.image,
    required this.text,
    required this.onPressed, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), 
        child: Container(
          color: Colors.white,
          width: 430,
          height: 180,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 8,
                left: 15,
                child: ElevatedButton(
                  onPressed: onPressed, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
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
